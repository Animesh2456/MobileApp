import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiFetching extends StatefulWidget {
  const ApiFetching({super.key});

  @override
  State<ApiFetching> createState() => _ApiFetchingState();
}

class _ApiFetchingState extends State<ApiFetching> {

  List<Photos> photoList=[];
  Future<List<Photos>>? futureUsers; // Step 1

  Future<List<Photos>> fetchUsers() async{
      print('Fetching User');

      final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (compatible; Flutter)',
          'Accept': 'application/json',
        },
      );
        
      print('Status code ${response.statusCode}');
      print('Response body ${response.body}');

      var data=jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map<String, dynamic> i in data){
          photoList.add(Photos.fromJson(i));
        }
        return photoList;
      } else {
        throw Exception('Failed to load user');
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('Api Fetching',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
         backgroundColor: Colors.orange,
       ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () async{
                    try{
                      setState(() {
                        futureUsers = fetchUsers(); // Step 2
                      });
                      List<Photos> value  =await fetchUsers();
                      for(var i in value){
                        print(i.id);
                        print(i.name);
                        print(i.username);
                      }
                    }
                    catch(e){
                      print(e);
                    }
                  }, child: Text('call API',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          maximumSize: Size(250,50)
                      )
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      photoList.clear(); // Clear the list
                    });
                  },
                  child: Text('Clear', style: TextStyle(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(190, 50)
                  ),

                ),
              ],
         ),
          futureUsers == null
              ? Container()  // Takes no space
              : Expanded(
            child: FutureBuilder(
                future: fetchUsers(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(strokeWidth: 3)),
                    ); // show loading
                  }else if(!snapshot.hasData){
                    return Text('Loading');
                  }else{
                    return Expanded(
                      child: ListView.builder(
                          itemCount: photoList.length,
                          itemBuilder: (context,index){
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
            
                                  title: Text(photoList[index].name ?? '',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  subtitle: Text(photoList[index].username ?? ''),
                                  trailing: Text('ID: ${photoList[index].id ?? 0}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                },
            ),
          )
        ],
      ),
    );
  }
}

class Photos{
   final int? id;
   final String? name;
   final String? username;

   Photos({required this.id,required this.name,required this.username});

   factory Photos.fromJson(Map<String, dynamic> json) {
     return Photos(
       id: json['id'],
       name: json['name'],
       username: json['username']
     );
   }
}
