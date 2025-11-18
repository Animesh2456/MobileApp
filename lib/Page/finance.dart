import 'package:flutter/material.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Finance',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
         backgroundColor: Colors.orange,
       ),
    );
  }
}
