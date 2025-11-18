import 'package:flutter/material.dart';
import 'package:first_login/customs/CustomDataTable.dart';

class Claims extends StatefulWidget {
  const Claims({super.key});

  @override
  State<Claims> createState() => _ClaimsState();
}

class _ClaimsState extends State<Claims> {
  final List<String> tableColumns = ['ID', 'Name', 'Age','DOJ','Year','Months'];

  final List<Map<String, dynamic>> tableData = [
    {'ID': 1, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 2, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 3, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 4, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 5, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 6, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 7, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 8, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 9, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 10, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 11, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 12, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 13, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 14, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 15, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 16, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 17, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 18, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 19, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 20, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 21, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 22, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 23, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 24, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
    {'ID': 25, 'Name': 'Alice', 'Age': 25,'DOJ':'12/05/25','Year':25,'Months':2},
    {'ID': 26, 'Name': 'Bob', 'Age': 30,'DOJ':'12/05/25','Year':35,'Months':3},
    {'ID': 27, 'Name': 'Charlie', 'Age': 22,'DOJ':'12/05/25','Year':45,'Months':4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('Claims',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
         backgroundColor: Colors.orange,
       ),
      body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Customdatatable(
              columns: tableColumns,
              data: tableData,
    ),
    ),
    );
  }
}
