import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_group/bookeditingpage.dart';
import 'package:v_group/costoms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_group/imagepage.dart';
import 'package:http/http.dart' as http;

TextEditingController _contentController = TextEditingController();

class AboutsPage extends StatefulWidget {
  const AboutsPage({super.key});

  @override
  State<AboutsPage> createState() => _AboutsPageState();
}

class _AboutsPageState extends State<AboutsPage> {
  String authToken = '';

  Future<void> fetchaboutInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
    });
    try {
      final response = await http.get(
        Uri.parse('http://vgroups-api.pharma-sources.com/api/about/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);
        print('Parsed Data about data: $data');

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {});
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
    fetchaboutInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(context),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor('368FF8'),
                HexColor('025CAF'),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        title: const Text(
          'About Page',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavBar(context, 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'வல்லரசு கட்சி நிலையான நிர்வாகத்தை வழங்கி, சட்டம் மற்றும் நீதியின் ஆட்சியை நிலைநிறுத்தி, தனிநபர்களின் உரிமைகள் மற்றும் நல்வாழ்வைப் பாதுகாக்கும்.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF4D4D4D),
                    fontSize: 14.00,
                    fontFamily: 'Alata',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    letterSpacing: 0.44,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'More Videos',
                        style: TextStyle(
                          color: Color(0xFF257FE0),
                          fontSize: 20,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 230,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 6,
                        offset: Offset(0, 0),
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Image.asset('assets/images/videos.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'More Photos',
                        style: TextStyle(
                          color: Color(0xFF257FE0),
                          fontSize: 20,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImagePage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 230,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 6,
                        offset: Offset(0, 0),
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Image.asset('assets/images/photos.png'),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
