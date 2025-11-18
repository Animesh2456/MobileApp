import 'dart:async';
import 'dart:convert';

import 'package:first_login/Page/home.dart';
import 'package:first_login/Page/login_second.dart';
import 'package:first_login/customs/TextForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:first_login/customs/ButtonCustom.dart';
import 'package:flutter/gestures.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _PasswordController=TextEditingController();
  bool _showOTPField=false;
  bool _showRegisterButton=false;
  
  int _start = 60;
  bool _isButtonDisabled = false;
  Timer? _timer;

  final PageController _controller = PageController();
  int _currentPage = 0;
  final  _otpController = TextEditingController();
  bool _isNextButton=false;


  void _goToNextPage() {
    if (_currentPage < 2) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _start = 60;
      _isButtonDisabled = true;
    });

    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _isButtonDisabled = false;
          timer.cancel();
        }
      });
    });
  }


  void sendOTPtoBackend(String email) async{
    String url = "http://10.0.2.2:8080/api/otp/generate";
    startTimer();
    // Create the request body
    Map<String, String> requestBody = {
      "email": email,
    };

    // Send the POST request
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {

      setState(() {
        _showOTPField = true;
        _isNextButton=true;
        _showRegisterButton=false;
      });
       //_showOTPField=true;
      print("OTP Sent successfully!");
      // Navigator.push(context,
      //     // MaterialPageRoute(builder: (context)=> LoginSecond())
      // );
    } else {
      setState(() {
        _showOTPField = false;
       // _emailController.clear();
       // _showRegisterButton=true;
      });
      //print("Error: ${response.body}");
      print("user not found in DB");

      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("User Not Found"),
          content: Text("No user found with this email. Would you like to register?"),
          actions: [
            CupertinoDialogAction(
              child: Text("Cancel"),
             // onPressed: () => Navigator.of(context).pop(),  // this will back to normal page
              onPressed: (){
                setState(() {
                  _showRegisterButton=true;
                });
                Navigator.of(context).pop();

              },
            ),
            CupertinoDialogAction(
              child: Text("Register"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, 'register');
              },
            ),
          ],
        ),
      );

    }

  }
  
  void sendOTP() async{
    print("send otp function started");
    final otp = _otpController.text.trim();
    String url = "http://10.0.2.2:8080/api/otp/varify";

    // Create the request body
    Map<String, String> requestBody = {
      "otp": otp,
    };

    // Send the POST request
    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
     // String body = response.body.trim().toLowerCase();

      print("Response: ${response.body}");

      if (response.body.contains("OTP varified")) {
        print("OTP verified! Navigating to home...");

        // ✅ Navigate to HomePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }else {
        // Show popup dialog if OTP is wrong
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("OTP Error"),
           // content: Text("The OTP you entered is incorrect. To resend the OTP click On Resend Button1"),

            actions: [
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: "You have entered Incorrect OTP, For new OTP click here-> "),
                    TextSpan(
                      text: "Resend OTP",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle tap (e.g., navigate to sign-up page)
                          setState(() {
                            _isButtonDisabled=true;
                          });
                          _isButtonDisabled ?sendOTPtoBackend(_emailController.text.toString()):null;
                          _otpController.clear();
                          Navigator.of(context).pop();
                          print("OTP Resended!");
                        },
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("OK"),
              ),
              // TextButton(
              //     onPressed: (){
              //      setState(() {
              //        _isButtonDisabled=true;
              //      });
              //       _isButtonDisabled ?sendOTPtoBackend(_emailController.text.toString()):null;
              //       _otpController.clear();
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('Resend Button',))
            ],
          )
        );
      }


      print("OTP varified!");
      // Navigator.push(context,
      //     // MaterialPageRoute(builder: (context)=> LoginSecond())
      // );
    } else {
      //print("Error: ${response.body}");
      print("Api is not getting hitted");
    }

  }

  void verifyOTP() {
    final otp = _otpController.text.trim();
    // TODO: Verify OTP with backend
    print("Verifying OTP: $otp");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('Forget Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)),
         backgroundColor: Colors.orange,
       ),
      body: PageView(
        controller: _controller,
       // scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(), // disables swipe
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page; // Track current page
          });
        },
        children: [
          // First Page
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  style: TextStyle(
                    fontSize: 18, // Increase this number to make the text larger
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, // Make it bold
                      fontSize: 18,                // Optional: Adjust font size
                      // color: Colors.black,         // Optional: Change label color
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), // 👈 Rounded corners here
                    ),
                    // suffixIcon: IconButton(
                    //   icon: const Icon(Icons.remove_red_eye_outlined,color:Colors.green),
                    //   onPressed: (){},
                    // ),
                    prefixIcon: const Icon(Icons.email,color: Colors.blue,),
                    filled: true,
                    // fillColor: Color(0xFFF5F5F5),
                    fillColor:const Color(0xFFF7F8F9),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 55,
                ),
                // Below TextForm is for use of custom TextFormField
                // TextForm(
                //   label:"Password" ,
                //   controller: _PasswordController,
                //   keyboardType: TextInputType.text,
                //   validator: (value)=>  value == null || value.isEmpty ? "Email is required" : null,
                //   //prefixIcon: Icon(Icons.lock),
                //   obscureText: true,
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold,
                //   decoration: InputDecoration(
                //     labelText: 'Email',
                // ),
                // ),


                  SizedBox(
                    height: 20,
                  ),

                ElevatedButton(
                  onPressed:(){

                    String email = _emailController.text.trim();

                    if (email.isEmpty) {
                      print("Please enter your email");
                      // Show Snackbar or AlertDialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter your email')),
                      );
                      return;
                    }

                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                      print('Enter a valid email');
                      ScaffoldMessenger.of(context).showSnackBar(

                        SnackBar(content: Text('Enter a valid email')),
                      );
                      return;
                    }
                    // _showOTPField=true;

                    sendOTPtoBackend(_emailController.text.toString());

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(horizontal: 75, vertical: 17),
                    textStyle: TextStyle(fontSize: 15),
                    shape: RoundedRectangleBorder(
                      //borderRadius: BorderRadius.zero,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Text(
                    "Send OTP",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 25),
                    if(_isNextButton) ...[

                      ElevatedButton(onPressed: (){

                        _goToNextPage();
                      },child: Text('Next',style: TextStyle(fontSize: 20),))
                    ],

                    if(_showRegisterButton) ...[
                      ElevatedButton(onPressed: (){
                        Navigator.pushNamed(context, 'register');
                      }, child: Text('Register',style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          )
                      )

                    ],



                  ],
                ),
                SizedBox(
                  height: 50,
                ),




              ],
            ),
          ),

            //Second Page
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    controller: _otpController,
                    decoration: const InputDecoration(
                      labelText: "Enter OTP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 26),

                  ElevatedButton(
                    onPressed: (){
                      String otp = _otpController.text.trim();

                      if (otp.isEmpty) {
                        print("Please enter your otp");
                        // Show Snackbar or AlertDialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter your otp')),
                        );
                        return;
                      }
                      sendOTP();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 75,vertical: 17),
                      shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.zero,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Text("Verify OTP",style: TextStyle(color:Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_isButtonDisabled)
                        Text(
                          'Resend in $_start sec',
                          style: TextStyle(fontSize: 14, color: Colors.blue[600]),
                        ),
                      if(!_isButtonDisabled)
                        ElevatedButton(onPressed: (){
                          startTimer();
                        }, child:Text('Resend OTP'))
                    ],

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // ElevatedButton(
                  //   onPressed:(){
                  //
                  //     String email = _emailController.text.trim();
                  //
                  //     if (email.isEmpty) {
                  //       print("Please enter your email");
                  //       // Show Snackbar or AlertDialog
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text('Please enter your email')),
                  //       );
                  //       return;
                  //     }
                  //
                  //     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                  //       print('Enter a valid email');
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //
                  //         SnackBar(content: Text('Enter a valid email')),
                  //       );
                  //       return;
                  //     }
                  //     // _showOTPField=true;
                  //
                  //     _isButtonDisabled ? null:sendOTPtoBackend(_emailController.text.toString());
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.blue,
                  //     padding: EdgeInsets.symmetric(horizontal: 60, vertical: 17),
                  //     textStyle: TextStyle(fontSize: 15),
                  //     shape: RoundedRectangleBorder(
                  //       //borderRadius: BorderRadius.zero,
                  //       borderRadius: BorderRadius.circular(40),
                  //     ),
                  //   ),
                  //   child: Text( 'Resend OTP',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 23,color: Colors.white),),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     if(_showRegisterButton) ...[
                  //       ElevatedButton(onPressed: (){
                  //         Navigator.pushNamed(context, 'register');
                  //       }, child: Text('Register',style: TextStyle(color: Colors.white),),
                  //           style: ElevatedButton.styleFrom(
                  //               backgroundColor: Colors.green
                  //           )
                  //       )
                  //
                  //     ],
                  //     // Buttoncustom(
                  //     //   label: 'Login',
                  //     //   onPressed: () {
                  //     //     // Your login logic
                  //     //   },
                  //     //   color: Colors.green,
                  //     //   textColor: Colors.white,
                  //     //   fontSize: 18,
                  //     // ),
                  //   ],
                  // ),
                ],

            ),
          ),



        ],
      )
    );

  }
}




