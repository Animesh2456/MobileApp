import 'package:flutter/material.dart';
// import 'package:media_store_plus/media_store_plus.dart';
import 'package:open_filex/open_filex.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;


import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
// import 'package:open_file/open_file.dart';

// import 'package:file_picker/file_picker.dart';




class Pdfcustom extends StatefulWidget {
  const Pdfcustom({super.key});

  @override
  State<Pdfcustom> createState() => _PdfcustomState();


  static Future<Uint8List> loadImageBytes(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }
  pw.Widget logoSection(Uint8List imageBytes) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(12.0),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'Quote Ref:',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Image(
                pw.MemoryImage(imageBytes), // Pass the logo image as bytes
                width: 70,
                height: 70,
                fit: pw.BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }
  pw.Widget customerDetailsWidget(Map<String, dynamic> myData) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.green, width: 1),
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(12)),
        ),
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Text(
                    'Customer Details',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Row 1: Client Name & Occupation
              pw.Padding(
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Client Name',
                          value: myData['clientName'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Occupation',
                          value: myData['occupation'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Row 2: Email & Phone
              pw.Padding(
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Email',
                          value: myData['email'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Phone',
                          value: myData['phone'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Row 3: Date of Birth & Gender
              pw.Padding(
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Date Of Birth',
                          value: myData['dob'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Gender',
                          value: myData['gender'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  pw.Widget productInformationWidget(Map<String, dynamic> myData) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8.0),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.green, width: 1),
          borderRadius: pw.BorderRadius.all(pw.Radius.circular(12)),
        ),
        child: pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Column(
            children: [
              pw.Row(
                children: [
                  pw.Text(
                    'Product Information',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Row 1: Product & Paying Term
              pw.Padding(
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Product',
                          value: myData['product'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Paying Term',
                          value: myData['policyTerm'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Row 2: Premium Paying Term & Working Age
              pw.Padding(
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Premium Paying Term',
                          value: myData['premiumPayingTerm'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Working Age',
                          value: myData['workingAge'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Row 3: Sum Assured
              pw.Padding(
                padding: const pw.EdgeInsets.all(5.0),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.SizedBox(
                        height: 42,
                        child: buildPdfTextField(
                          label: 'Sum Assured',
                          value: myData['sum Assured'] ?? '',
                          fontSize: 10,
                          fontWeight: pw.FontWeight.normal,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pw.Widget premiumDetailsWidget(
      Map<String, dynamic> myData,
      List<String> tableColumns,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.green, width: 1),
          borderRadius: pw.BorderRadius.circular(12),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                'Premium Details',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            buildTable2(myData['premiumTable'], tableColumns),
          ],
        ),
      ),
    );
  }
  pw.Widget anticipatedMaturityProjectionWidget(
      Map<String, dynamic> myData,
      List<String> table1Columns,
      ) {
    return pw.Wrap(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.green, width: 1),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(5),
                  child: pw.Text(
                    'Anticipated Maturity Projection',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                buildTable2(myData['Anticipated'], table1Columns),
              ],
            ),
          ),
        ),
      ],
    );
  }


  pw.Widget projectedGainLossWidget(
      Map<String, dynamic> myData,
      List<String> table2Columns,
      ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.green, width: 1),
          borderRadius: pw.BorderRadius.circular(12),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                'Projected Gain Loss',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            buildTable2(myData['gainLossTable'], table2Columns),
          ],
        ),
      ),
    );
  }


  pw.Widget clauseAndProvisionsWidget() {
    return pw.Container(
      constraints: pw.BoxConstraints(minWidth: 390),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(
              'Clauses and Provisions',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(
              'Validity Of Quotation',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'This quotation does not guarantee insurability, nor does it signify coverage and is valid for 30 days from the date '
                  'of this quotation or before the next birthday, whichever comes first.',
              style: pw.TextStyle(fontSize: 14),
              textAlign: pw.TextAlign.justify,
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(
              'Disclaimer',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Text(
              'The illustrative values represented here are based on stated assumptions and are indicative rates only. The figures may vary dependent on factors such as the age and gender of the client, claims experience, and other such variable features. Accordingly, CIC Life does not warrant, nor does it guarantee the figures represented. CIC Life cannot be held liable for any damages arising from any transactions or omissions and the resultant actions arising from the information '
                  'contained in the illustrative values.',
              style: pw.TextStyle(fontSize: 14),
              textAlign: pw.TextAlign.justify,
            ),
          ),
          pw.SizedBox(height: 30),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Prepared By:',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Approved By:',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Client Name:',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Row(
              children: [
                pw.Text('Quote Date:',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 4),
                pw.Text('15-07-2025', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Row(
              children: [
                pw.Text('Quote Date:',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 4),
                pw.Text('15-07-2025', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Row(
              children: [
                pw.Text('Review Date:',
                    style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(width: 4),
                pw.Text('15-07-2025', style: pw.TextStyle(fontSize: 16)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Padding(
            padding: const pw.EdgeInsets.all(2),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Remark __________________________',
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 60),
              ],
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 40),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(6),
              child: pw.Center(
                child: pw.Text(
                  'In case of any further queries, kindly feel free to get in touch with '
                      'CIC Life Assurance through email lifecare@cic.co.ke or 0703099120. We Keep Our Word',
                  style: pw.TextStyle(fontSize: 12),
                  textAlign: pw.TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  static pw.Widget buildPdfTextField({
    required String label,
    required String value,
    double fontSize = 12,
    pw.FontWeight fontWeight = pw.FontWeight.normal,
    double spacing = 8,
    double inputWidth = 200,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Label text
        pw.Text(
          '$label:',
          style: pw.TextStyle(
            fontSize: fontSize,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: spacing),
        pw.Container(
          width: inputWidth,
          padding: const pw.EdgeInsets.only(bottom: 2),
          decoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.black, width: 1),
            ),
          ),
          child: pw.Text(
            value,
            style: pw.TextStyle(
              fontSize: fontSize,
            ),
          ),
        ),

        pw.SizedBox(height: 12), // spacing after each field
      ],
    );
  }


  static pw.Widget buildTable2(List<Map<String, dynamic>> data, List<String> columns) {
    return pw.Table.fromTextArray(
      headers: columns,
      data: data.map((row) => columns.map((col) => '${row[col] ?? ''}').toList()).toList(),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 10,
      ),
      cellStyle: const pw.TextStyle(fontSize: 10),
      // 🟢 Border Color
      border: pw.TableBorder.all(width: 0.5, color: PdfColors.orange),

      // 🟢 Header Background
      headerDecoration: const pw.BoxDecoration(color: PdfColors.orange300),
      // cellDecoration: const pw.BoxDecoration(
      //   color: PdfColors.green50, // Light green cell background
      // ),



      cellAlignment: pw.Alignment.centerLeft,
      columnWidths: {
        for (int i = 0; i < columns.length; i++) i: const pw.FlexColumnWidth(),
      },
    );
  }


  void generateOneMorePdf(BuildContext context,Map<String,dynamic> myData, List<String> tableColumns,
      List<String> table1Columns,List<String> table2Columns) async{
    final pdf = pw.Document();

    final imageBytes = await loadImageBytes('assets/images/CIC_Group_Logo.png');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(8),
        build: (pw.Context context) => [
         //logo
          logoSection(imageBytes),

          // 🟢 Customer Details Section
          customerDetailsWidget(myData),

          // 🟢 Product Info Section
          productInformationWidget(myData),

          // 🟢 Premium Details
          premiumDetailsWidget(myData, tableColumns),

          // 🟢 Anticipated Maturity Projection
          anticipatedMaturityProjectionWidget(myData, table1Columns),

          // 🟢 Projected Gain/Loss
          projectedGainLossWidget(myData, table2Columns), //
          // 🟢 Clauses and Provisions
          clauseAndProvisionsWidget(),
        ],
      ),
    );


    // Convert PDF to bytes
    Uint8List pdfBytes = await pdf.save();

// Get app-private external storage directory
    final dir = await getExternalStorageDirectory(); // Safe, Play Store compliant // app-private storage

// Create file path
    String filePath = "${dir!.path}/quotation_${DateTime.now().millisecondsSinceEpoch}.pdf";

// Save PDF
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);

// Open PDF immediately
    await OpenFilex.open(filePath);

// Wait until the user comes back
    Future.delayed(Duration(seconds: 1), () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Download Complete"),
          content: Text("📄 PDF saved to:\n$filePath"),
          actions: [
            TextButton(
              onPressed: () async {
                await OpenFilex.open(filePath);
              },
              child: const Text('Open'),
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });





    //2 using SAF
    // // Convert to bytes
    // Uint8List pdfBytes = await pdf.save();
    //
    // // Ask user once where to save (SAF)
    // String? savedPath = await FilePicker.platform.saveFile(
    //   dialogTitle: 'Save Quotation PDF',
    //   fileName: 'quotation_${DateTime.now().millisecondsSinceEpoch}.pdf',
    //   bytes: pdfBytes,
    //   type: FileType.custom,
    //   allowedExtensions: ['pdf'],
    // );
    //
    // if (savedPath != null) {
    //   // Open PDF immediately after saving
    //   await OpenFilex.open(savedPath);
    //
    //   // Wait a second, then show "Download complete"
    //   Future.delayed(const Duration(seconds: 1), () {
    //     showDialog(
    //       context: context,
    //       builder: (_) => AlertDialog(
    //         title: const Text("Download Complete"),
    //         content: Text("📄 PDF saved to:\n$savedPath"),
    //         actions: [
    //           TextButton(
    //             child: const Text("Open Again"),
    //             onPressed: () async {
    //               Navigator.of(context).pop();
    //               await OpenFilex.open(savedPath);
    //             },
    //           ),
    //           TextButton(
    //             child: const Text("OK"),
    //             onPressed: () => Navigator.of(context).pop(),
    //           ),
    //         ],
    //       ),
    //     );
    //   });
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Save cancelled')),
    //   );
    // }


  }

}



class _PdfcustomState extends State<Pdfcustom> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
