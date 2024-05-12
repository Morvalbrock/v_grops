import 'dart:convert';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Cources_Page extends StatefulWidget {
  const Cources_Page({super.key});

  @override
  State<Cources_Page> createState() => _Cources_PageState();
}

class _Cources_PageState extends State<Cources_Page> {
  List<dynamic> alldata = [];
  List<dynamic> categoryItemlist = [];
  List<dynamic> categoryItemlist1 = [];
  List<dynamic> categoryItemlist2 = [];
  List<dynamic> categoryItemlist3 = [];
  List<dynamic> categoryItemlist4 = [];
  List<String> subCourseTitles = [];
  String authToken = '';
  var _selectedVal;
  var _selectedVal1;
  var _selectedVal2;
  var _selectedVal3;
  var _selectedVal4;
  Future<void> fetchBookInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
    });
    try {
      final response = await http.get(
        Uri.parse('https://vgroups-api.pharma-sources.com/api/courses/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);
        print('Parsed Data categoryItemlist: $categoryItemlist');
        setState(() {
          alldata = data;
          categoryItemlist = alldata[0]['sub_courses'];

          _selectedVal =
              categoryItemlist.isNotEmpty ? categoryItemlist[0]['title'] : null;
          //2nd dropdown
          categoryItemlist1 = alldata[1]['sub_courses'];

          _selectedVal1 = categoryItemlist1.isNotEmpty
              ? categoryItemlist1[0]['title']
              : null;

          //3rd dropdown
          categoryItemlist2 = alldata[2]['sub_courses'];

          _selectedVal2 = categoryItemlist2.isNotEmpty
              ? categoryItemlist2[0]['title']
              : null;

          //4th dropdown
          categoryItemlist3 = alldata[3]['sub_courses'];

          _selectedVal3 = categoryItemlist3.isNotEmpty
              ? categoryItemlist3[0]['title']
              : null;

          //5th dropdown
          categoryItemlist4 = alldata[4]['sub_courses'];

          _selectedVal4 = categoryItemlist4.isNotEmpty
              ? categoryItemlist4[0]['title']
              : null;
        });
      } else {
        // Handle errors
        print('Failed to load user information');
      }
    } catch (e) {
      // Handle network errors
      print('Network error: $e');
    }
  }

  @override
  void initState() {
    fetchBookInfo();
    // _selectedVal = subCourseTitles[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Cover Picture
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200, // Adjust height as needed
                    color: Color(
                        0xFF257FE0), // Example color, you can replace it with an image
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 40,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                // Profile Picture
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.20,
                  top: 130,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 68,
                    child: CircleAvatar(
                      radius: 62,
                      backgroundImage: AssetImage('assets/images/readbook.png'),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.courses_titile1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Alata',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 350,
                            // height: 350,
                            decoration: ShapeDecoration(
                              color: Color(0xFFD9D9D9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.courses_titile2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                                alignment: Alignment.center,
                                // margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  // const Color(0xfffeeeee)
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 223, 221, 221),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    elevation: 2,
                                    isExpanded: true,
                                    iconEnabledColor: Colors.blue,
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    value: _selectedVal,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedVal = newValue!;
                                      });
                                    },
                                    items: categoryItemlist
                                        .map<DropdownMenuItem<String>>(
                                            (subCourse) {
                                      return DropdownMenuItem<String>(
                                        value: subCourse['title'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(subCourse['title']),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    // const Color(0xfffeeeee)
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 223, 221, 221),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      elevation: 2,
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      iconEnabledColor: Colors.blue,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      value: _selectedVal1,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedVal1 = newValue!;
                                        });
                                      },
                                      items: categoryItemlist1
                                          .map<DropdownMenuItem<String>>(
                                              (subCourse) {
                                        return DropdownMenuItem<String>(
                                          value: subCourse['title'],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(subCourse['title']),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  // margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    // const Color(0xfffeeeee)
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 223, 221, 221),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      elevation: 2,
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      iconEnabledColor: Colors.blue,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      value: _selectedVal2,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedVal2 = newValue!;
                                        });
                                      },
                                      items: categoryItemlist2
                                          .map<DropdownMenuItem<String>>(
                                              (subCourse) {
                                        return DropdownMenuItem<String>(
                                          value: subCourse['title'],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(subCourse['title']),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  // margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    // const Color(0xfffeeeee)
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 223, 221, 221),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      elevation: 2,
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      iconEnabledColor: Colors.blue,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      value: _selectedVal3,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedVal3 = newValue!;
                                        });
                                      },
                                      items: categoryItemlist3
                                          .map<DropdownMenuItem<String>>(
                                              (subCourse) {
                                        return DropdownMenuItem<String>(
                                          value: subCourse['title'],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(subCourse['title']),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  height: 30,
                                  alignment: Alignment.centerLeft,
                                  // margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    // const Color(0xfffeeeee)
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 223, 221, 221),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      elevation: 2,
                                      isExpanded: true,
                                      iconEnabledColor: Colors.blue,
                                      alignment: Alignment.center,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      value: _selectedVal4,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedVal4 = newValue!;
                                        });
                                      },
                                      items: categoryItemlist4
                                          .map<DropdownMenuItem<String>>(
                                              (subCourse) {
                                        return DropdownMenuItem<String>(
                                          value: subCourse['title'],
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(subCourse['title']),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          key: const Key('showMore'),
                          padding: const EdgeInsets.all(16.0),
                          child: ReadMoreText(
                            AppLocalizations.of(context)!.courses_titile3,
                            trimLines: 2,
                            preDataText: "AMANDA",
                            preDataTextStyle:
                                TextStyle(fontWeight: FontWeight.w500),
                            style: TextStyle(color: Colors.black),
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...Show more',
                            trimExpandedText: ' show less',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
