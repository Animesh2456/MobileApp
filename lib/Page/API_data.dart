import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiData extends StatefulWidget {
  const ApiData({super.key});

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> {


  List<User> userList=[];

  Future<List<User>>? futureUsers; // Step 1

  Future<List<User>> fetchUser() async {
    print('Fetching user...'); // debug
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {
        'User-Agent': 'Mozilla/5.0 (compatible; Flutter)',
        'Accept': 'application/json',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data=jsonDecode(response.body.toString());    //this line will convert json into dart
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data){
        userList.add(User.fromJson(i));
      }
      return userList;
    } else {
      throw Exception('Failed to load user');
      return userList;
    }
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('API DATA',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
          backgroundColor: Colors.orange,
        ),

       body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 ElevatedButton(onPressed: () async {
                   try {
                     setState(() {
                       futureUsers = fetchUser(); // Step 2
                     });
                     final List<User> value = await fetchUser();
                     for (var user in value) {
                       print(user.id);
                       print(user.name);
                       print(user.username);
                     }
                   } catch (e) {
                     print('Error: $e');
                   }
                 }, child: Text('API Request',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                     style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.blue,
                         minimumSize: Size(100, 50)
                     )
                 ),
                 Padding(
                   padding: const EdgeInsets.all(5.0),
                   child: ElevatedButton(
                     onPressed: () {
                       setState(() {
                         userList.clear(); // Clear the list
                       });
                     },
                     child: Text('Clear', style: TextStyle(fontSize: 20)),
                     style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.red,
                         minimumSize: Size(190, 50)
                     ),

                   ),
                 ),
               ],
             ),
           ),
           futureUsers == null
               ? Container()  // Takes no space
               : Expanded(
             child: FutureBuilder<List<User>>(
               future: futureUsers,         // Here we giving the function name in which API persist
               builder: (context,snapshot){
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return Align(
                     alignment: Alignment.center,
                     child: SizedBox(
                         width: 30,
                         height: 30,
                         child: CircularProgressIndicator(strokeWidth: 3)),
                   ); // show loading
                 }
                 if(!snapshot.hasData){
                   return Text('Loading');
                 }else{
                   return ListView.builder(
                       itemCount: userList.length,
                       itemBuilder: (context,index){
                         return Card(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                                children: [
                                  _buildViewValue('ID', userList[index].id.toString()),
                                  _buildViewValue('Name', userList[index].name),
                                  _buildLabelValue('Username', userList[index].username),
                                  _buildLabelValue('Email', userList[index].email),
                                  const SizedBox(height: 10),
                                  const Text('Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  _buildLabelValue('Street', userList[index].address.street),
                                  _buildLabelValue('Suite', userList[index].address.suite),
                                  _buildLabelValue('City', userList[index].address.city),
                                  _buildLabelValue('Zipcode', userList[index].address.zipcode),
                                  const SizedBox(height: 10),
                                  const Text('Geo Coordinates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  _buildLabelValue('Latitude', userList[index].address.geo.lat),
                                  _buildLabelValue('Longitude', userList[index].address.geo.lng),
                                ],
                             ),
                           ),
                         );
                       });
                 }
               },
             ),
           ),
         ],
       ),
     );
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    address: Address.fromJson(json['address']),
    phone: json['phone'],
    website: json['website'],
    company: Company.fromJson(json['company']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'address': address.toJson(),
    'phone': phone,
    'website': website,
    'company': company.toJson(),
  };
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: Geo.fromJson(json['geo']),
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'suite': suite,
    'city': city,
    'zipcode': zipcode,
    'geo': geo.toJson(),
  };
}

class Geo {
  final String lat;
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    lat: json['lat'],
    lng: json['lng'],
  );

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng,
  };
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    name: json['name'],
    catchPhrase: json['catchPhrase'],
    bs: json['bs'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'catchPhrase': catchPhrase,
    'bs': bs,
  };
}

Widget _buildLabelValue(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

Widget _buildViewValue(String label,String value){
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 2),
     child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
           Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold),),
           Expanded(child: Text(value)),
       ],
     ),
   );
}