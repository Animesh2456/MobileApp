import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ApiDisplay extends StatefulWidget {
  const ApiDisplay({super.key});

  @override
  State<ApiDisplay> createState() => _ApiDisplayState();
}

class _ApiDisplayState extends State<ApiDisplay> {

  int _rowsPerPage = 5;
  int _currentPage = 0;
  int _totalPages = 1;


  List<User> users=[];
  bool isLoading = true;

  // List<User> get paginatedUsers {
  //   int startIndex = _currentPage * _rowsPerPage;
  //   int endIndex = startIndex + _rowsPerPage;
  //   return users.sublist(
  //     startIndex,
  //     endIndex > users.length ? users.length : endIndex,
  //   );
  // }


  @override
  void initState() {
    super.initState();
   // users = []; // Clear old data before fetching
    fetchUsers(_currentPage,_rowsPerPage);
  }

  Future<void> fetchUsers(int page, int size) async {

    setState(() {
      isLoading = true;
      users = []; // Clear old data before fetching
    });

    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/auth/api/getRegister?page=$page&size=$size')
    );


    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> content = jsonData['content'];
      print("Total Pages from API: ${jsonData['totalPages']}");
      _totalPages=jsonData['totalPages'];
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        users = content.map((item) => User.fromJson(item)).toList();
        isLoading = false;
        // You can also extract: totalPages = jsonData['totalPages'];
      });
    } else {
      print("Failed to load users");
      setState(() => isLoading = false);
    }
  }

  void _goToPage(int newPage) {
    setState(() {
      _currentPage = newPage;
      isLoading = true;
    });
    fetchUsers(_currentPage, _rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Center(child: Text('API Display',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
         backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(height: 100,),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ID',style: TextStyle(fontSize: 20, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),)),
                          DataColumn(label: Text('Username',style: TextStyle(fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Email',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                        ],
                        rows: users.map((user) {
                          return DataRow(cells: [
                            DataCell(Text(user.id.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.blue))),
                            DataCell(Text(user.username,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                            DataCell(Text(user.email,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                            DataCell(Text(user.password,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _currentPage > 0
                        ? () => _goToPage(_currentPage - 1)
                        : null,
                    child: Text('Previous'),
                  ),
                  SizedBox(width: 16),
                  Text("Page ${_currentPage + 1} of $_totalPages"),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _currentPage < _totalPages - 1
                        ? () => _goToPage(_currentPage + 1)
                        : null,
                    child: Text('Next'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      )

    );
  }
}


class User{
  final int id;
  final String email;
  final String username;
  final String password;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }

}
