import 'dart:convert';

import 'package:Sivayogi_The_Guru/courses_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

class CourcesModel {
  final String topic;
  final String sub_title_1;
  final String sub_title_2;
  final String sub_title_3;
  final String sub_title_4;
  final String sub_title_5;
  final String sub_title_6;
  final String sub_title_7;
  final String sub_title_8;
  final String image;

  CourcesModel(
    this.topic,
    this.sub_title_1,
    this.sub_title_2,
    this.sub_title_3,
    this.sub_title_4,
    this.sub_title_5,
    this.sub_title_6,
    this.sub_title_7,
    this.sub_title_8,
    this.image,
  );

  factory CourcesModel.fromJson(Map<String, dynamic> json) {
    return CourcesModel(
      json['topic'],
      json['sub_title_1'],
      json['sub_title_2'],
      json['sub_title_3'],
      json['sub_title_4'],
      json['sub_title_5'],
      json['sub_title_6'].toString(),
      json['sub_title_7'].toString(),
      json['sub_title_8'].toString(),
      json['image'].toString(),
    );
  }
}

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<CourcesModel> allCourses = [];

  bool isLoading = false;
  void fetchUsers() async {
    final response = await http.get(
        Uri.parse('https://atomsinnerwears.com/atomsinnerwears/api/courses'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      // print(responseData);
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          isLoading = true;

          allCourses =
              responseData.map((json) => CourcesModel.fromJson(json)).toList();

          // print(allCourses);
        });
      });
    } else {
      print('Failed to load users');
    }
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cources Page',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading == true
          ? ListView.builder(
              itemCount: allCourses.length,
              itemBuilder: (context, index) => Container(
                // height: 300,
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xfffeeeee),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 63, 62, 62)
                          .withOpacity(0.50),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  // leading: Image.network(
                  //   displayItems[index].profile_url,
                  // ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourcesList(
                          alldata: allCourses,
                          index: index,
                        ),
                      ),
                    );
                    print(index);
                  },
                  dense: true,
                  title: Text(
                    allCourses[index].topic,
                  ),
                  subtitle: Text(
                    allCourses[index].sub_title_1,
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0, // Adjust the thickness of the indicator
                valueColor: AlwaysStoppedAnimation<Color>(
                  HexColor('368FF8'),
                ),
              ),
            ),
    );
  }
}
