import 'package:first_login/customs/TextFieldCustom.dart';
import 'package:flutter/material.dart';

class Customdatatable extends StatelessWidget {
  final List<String> columns;
  final List<Map<String, dynamic>> data;
  final ScrollController? scrollController;
  final Color? headingRowColor;
  final Color? dataRowColor;
  final Color? borderColor;
  final double? columnFontSize;
  final double? dataFontSize;

  const Customdatatable({
    super.key,
    required this.columns,
    required this.data,
    this.scrollController,
    this.headingRowColor,
    this.dataRowColor,
    this.borderColor,
    this.columnFontSize,
    this.dataFontSize
  });

  @override
  Widget build(BuildContext context) {


    final Map<String,dynamic> gardData={
       'Guardian Name':'John',
       'ID':123456,
       'Email':'abc@gmail.com',
       'Date Of Birth':'11/07/1999',
       'Age':15,
       'Country Code':259,
       'Relationship':['Mother','Father','Son','Daughter'],
       'Phone Number':99213243,
    };


    final screenWidth = MediaQuery.of(context).size.width;

    // Optional: Decide how wide the table should be
    final double minTableWidth = 390.0;
    final double tableWidth = screenWidth < minTableWidth ? minTableWidth : screenWidth;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: tableWidth),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DataTableTheme(
              data: DataTableThemeData(
                dividerThickness: 1,
                dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) => dataRowColor??Colors.orange[50],
                ),
              ),
              child: DataTable(
                horizontalMargin: 12,
                headingRowHeight: 30,
                columnSpacing: 40,
                dataRowMinHeight: 20,
                dataRowMaxHeight: 25,
                headingRowColor: MaterialStatePropertyAll(headingRowColor??Colors.orange[200]),
                border: TableBorder(
                  top:  BorderSide(width: 1, color:borderColor ?? Colors.orangeAccent),
                  right:  BorderSide(width: 1, color:borderColor ?? Colors.orangeAccent),
                  bottom:  BorderSide(width: 1, color:borderColor ?? Colors.orangeAccent),
                  left:  BorderSide(width: 1, color: borderColor ??Colors.orangeAccent),
                  verticalInside:  BorderSide(width: 1, color:borderColor ?? Colors.orangeAccent),
                  horizontalInside:  BorderSide(width: 1, color: borderColor ??Colors.orangeAccent),
                ),
                columns: columns.map((col) {
                  return DataColumn(
                    label: Text(
                      col,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: columnFontSize??8),
                    ),
                  );
                }).toList(),
                rows: data.map((row) {
                  return DataRow(
                    cells: columns.map((col) {
                      return DataCell(
                        col == 'Guardian'
                            ? (row['Age'] != null && row['Age'] is int && row['Age'] <= 18
                            ? ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Guardian Details'),
                                content: Column(
                                   children: [
                                     Textfieldcustom(
                                         label: 'Guardian Name',
                                         value: gardData['Guardian Name'],
                                       decoration: InputDecoration(
                                         label: Text('Guardian Name',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'ID',
                                       value: gardData['ID'].toString(),
                                       decoration: InputDecoration(
                                         label: Text('ID',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'Email',
                                       value: gardData['Email'],
                                       decoration: InputDecoration(
                                         label: Text('Email',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'Date Of Birth',
                                       value: gardData['Date Of Birth'],
                                       decoration: InputDecoration(
                                         label: Text('Date Of Birth',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'Age',
                                       value: gardData['Age'].toString(),
                                       decoration: InputDecoration(
                                         label: Text('Age',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'Country Code',
                                       value: gardData['Country Code'].toString(),
                                       decoration: InputDecoration(
                                         label: Text('Country Code',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'Relationship',
                                       value: gardData['Relationship'][0],
                                       decoration: InputDecoration(
                                         label: Text('Relationship',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                     SizedBox(height: 15,),
                                     Textfieldcustom(
                                       label: 'Phone Number',
                                       value: gardData['Phone Number'].toString(),
                                       decoration: InputDecoration(
                                         label: Text('Phone Number',style: TextStyle(fontSize: 14),),
                                         border: const OutlineInputBorder(),
                                       ),
                                     ),
                                   ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ],

                              ),
                            );
                          },
                          child: const Text('Add Guardian', style: TextStyle(fontSize: 10)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // 🔴 Button background color
                            foregroundColor: Colors.white, // ⚪ Text/icon color
                            elevation: 5, // Optional: shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Optional: rounded corners
                            ),
                          ),
                        )
                            : const Text('', style: TextStyle(fontSize: 10)))
                       : Text(
                          row[col]?.toString() ?? '',
                          style: TextStyle(fontSize:dataFontSize?? 8),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
