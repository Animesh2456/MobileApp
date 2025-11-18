import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Commonsearch extends StatefulWidget {
  const Commonsearch({super.key});

  @override
  State<Commonsearch> createState() => _CommonsearchState();
}

class _CommonsearchState extends State<Commonsearch> {

  @override
  void initState() {
    super.initState();
    // users = []; // Clear old data before fetching
    sendSearchRequest(_currentPage, _rowsPerPage);
  }

  List<Object> users=[];
  List<Country>countryListss=[];
 // List<Country> countryList = [];
  bool isLoading = true;
  bool _searchActive=false;

  int _rowsPerPage = 7;
  int _currentPage = 0;

  int totalRecords = 0;
  int totalPages = 0;
  int totalRecordsFiltered=0;
  int totalNoOfPagesFiltered=0;

  final _formKey = GlobalKey<FormState>();
   TextEditingController countryIdController = TextEditingController();
   TextEditingController countryNameController = TextEditingController();

  void _resetForm() {
    countryIdController.clear();
    countryNameController.clear();
  }

  /// Example usage: creating and sending the request
  Future<void> sendSearchRequest(_currentPage, _rowsPerPage) async {

    final countryIdValue = countryIdController.text.trim();
    final countryNameValue = countryNameController.text.trim();

  final searchRequest = SearchRequest(
  searchVO: {
  'countryId': SearchParameter(
  criteria: 'CONTAINS',
  dateFrom: '',
  dateTo: '',
  value: countryIdValue,
  type: 'String',
  ),
  'countryName': SearchParameter(
  criteria: 'CONTAINS',
  dateFrom: '',
  dateTo: '',
  value: countryNameValue,
  type: 'String',
  ),
  },
  vto: 'CountryVTO',
  vo: 'CountryVO',
   pageNo: _currentPage,
   pageSize:  _rowsPerPage,
  );

  final url = Uri.parse('http://10.0.2.2:9081/release-phase-2-core/CommonSearch/search1'); // 🔁 Replace with your actual backend URL

  try {
  final response = await http.post(
  url,
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(searchRequest.toJson()),
  );

  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    if (jsonList.isNotEmpty && jsonList.last is Map<String, dynamic>) {
      Map<String, dynamic> meta = jsonList.last as Map<String, dynamic>;

       totalRecords = meta['totalRecords'];
       totalPages = meta['totalPages'];
       totalRecordsFiltered=meta['totalRecordsFiltered'];
       totalNoOfPagesFiltered=meta['totalNoOfPagesFiltered'];


      List<Country> parsedCountries = jsonList
          .sublist(0, jsonList.length - 1)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();

      setState(() {
        countryListss = parsedCountries;
        totalRecords = totalRecords;
        totalPages = _searchActive ? totalNoOfPagesFiltered:totalPages;
        totalRecordsFiltered= _searchActive ? totalRecordsFiltered:totalRecordsFiltered;
        totalNoOfPagesFiltered=totalNoOfPagesFiltered;
        isLoading = false;
      });
    }

  }  else {
  print(" Failed: ${response.statusCode}");
  }
  } catch (e) {
  print(" Error sending request: $e");
  }
  }

  void _editCountry(Map<String, String> country) {
    print("Edit: $country");
  }

  void _deleteCountry(Map<String, String> country) {
    print("Delete: $country");
  }

  void _goToPage(int newPage) {
    setState(() {
      _currentPage = newPage;
      isLoading = true;
    });
    sendSearchRequest(_currentPage, _rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('Common Search',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
         backgroundColor: Colors.orange,
       ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: countryIdController,
                              decoration: InputDecoration(
                                labelText: "Country Prefix",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),

                          SizedBox(width: 16),

                          Expanded(
                            child: TextFormField(
                              controller: countryNameController,
                              decoration: InputDecoration(
                                labelText: "Country Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _resetForm();
                              _currentPage  = 0;
                              _searchActive = false;    // back to “all rows” mode
                              sendSearchRequest(_currentPage, _rowsPerPage);
                            },
                            child: Text("Reset"),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: (){
                              _currentPage  = 0;        // always start from the first page
                              _searchActive = true;     // we’re now in “filtered” mode
                              sendSearchRequest(_currentPage, _rowsPerPage);
                            },
                            child: Text("Search"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildCountryTable(),
            SizedBox(height: 16),
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
                  Text("Page ${_currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}"),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _currentPage < totalPages - 1
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
      ),
    );
  }

  Widget _buildCountryTable() {
    if (countryListss.isEmpty) {
      return Text("No data found.");
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text("Country ID")),
          DataColumn(label: Text("Country Name")),
          DataColumn(label: Text("Actions")),
        ],
        rows: countryListss.map((country) {
          return DataRow(cells: [
            DataCell(Text(country.countryId)),
            DataCell(Text(country.countryName)),
            DataCell(Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editCountry({
                    'id': country.countryId,
                    'name': country.countryName,
                  }),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteCountry({
                    'id': country.countryId,
                    'name': country.countryName,
                  }),
                ),
              ],
            ))
          ]);
        }).toList(),
      
      
      ),
    );
  }

}


class Country {
  // final int id;
  // final String createdDate;
  // final String updatedDate;
  final String countryId;
  final String countryName;
  final String countryCode;
  // final int countryOrder;

  Country({
    // required this.id,
    // required this.createdDate,
    // required this.updatedDate,
    required this.countryId,
    required this.countryName,
    required this.countryCode,
    // required this.countryOrder,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      // id: json['id'],
      // createdDate: json['createdDate'],
      // updatedDate: json['updatedDate'],
      countryId: json['countryId'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
      // countryOrder: json['countryOrder'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      // 'createdDate': createdDate,
      // 'updatedDate': updatedDate,
      'countryId': countryId,
      'countryName': countryName,
      'countryCode': countryCode,
      // 'countryOrder': countryOrder,
    };
  }
}


class SearchParameter {
  final String criteria;
  final String dateFrom;
  final String dateTo;
  final String value;
  final String type;

  SearchParameter({
    required this.criteria,
    required this.dateFrom,
    required this.dateTo,
    required this.value,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'criteria': criteria,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'value': value,
      'type': type,
    };
  }

  factory SearchParameter.fromJson(Map<String, dynamic> json) {
    return SearchParameter(
      criteria: json['criteria'],
      dateFrom: json['dateFrom'],
      dateTo: json['dateTo'],
      value: json['value'],
      type: json['type'],
    );
  }
}


class SearchRequest {
  final Map<String, SearchParameter> searchVO;
  final String vto;
  final String vo;
  final int? pageNo;
  final int? pageSize;

  SearchRequest({
    required this.searchVO,
    required this.vto,
    required this.vo,
     this.pageNo,
     this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'SearchVO': searchVO.map((key, value) => MapEntry(key, value.toJson())),
      'VTO': vto,
      'VO': vo,
      'PageNo': pageNo,
      'PageSize': pageSize,
    };
  }

  factory SearchRequest.fromJson(Map<String, dynamic> json) {
    final searchVoMap = (json['SearchVO'] as Map<String, dynamic>).map(
          (key, value) => MapEntry(key, SearchParameter.fromJson(value)),
    );

    return SearchRequest(
      searchVO: searchVoMap,
      vto: json['VTO'],
      vo: json['VO'],
      pageNo: json['PageNo'],
      pageSize: json['PageSize'],
    );
  }
}



