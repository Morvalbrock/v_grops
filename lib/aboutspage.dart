import 'dart:convert';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:Sivayogi_The_Guru/imagepage.dart';
import 'package:Sivayogi_The_Guru/videospage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

TextEditingController _contentController = TextEditingController();

class AboutsPage extends StatefulWidget {
  const AboutsPage(this._locale, {super.key});
  final Locale? _locale;
  @override
  State<AboutsPage> createState() => _AboutsPageState();
}

class _AboutsPageState extends State<AboutsPage> {
  String authToken = '';
  late List<dynamic> content = [];
  var content_english;
  var content_tamil;
  String firstname = '';
  String lastname = '';
  String email = '';
  String profile_url = '';
  String _locale_value = '';

  // late String refreshToken = '';
  // late DateTime tokenExpiry = DateTime.now();
  late bool isLoading = false;

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    } else {
      await fetchUserInfo();
    }

    // setState(() {
    //   _selectedImage = File(pickedImage.path);
    // });
  }

  Future<void> fetchUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
    });
    try {
      final response = await http.get(
        Uri.parse('https://vgroups-api.pharma-sources.com/api/user/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body
        Map<String, dynamic> data = json.decode(response.body);
        print('Parsed Data: $data');
        print(data['profile_pic']);
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            // Access the user information correctly
            isLoading = true;
            firstname = data['first_name'].toString();
            lastname = data['last_name'].toString();
            email = data['email'].toString();
            profile_url = data['profile_pic'].toString();
          });
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

  Future<void> fetchaboutInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
    });
    try {
      final response = await http.get(
        Uri.parse('https://vgroups-api.pharma-sources.com/api/about/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body
        // List<dynamic> data = json.decode(response.body);
        // print('Parsed Data about data: $data');

        final responseBody = utf8.decode(response.bodyBytes);
        print("Books Data decode $responseBody");

        List<dynamic> data = json.decode(responseBody);
        print('Parsed Data about data: $data');

        // Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          content = data;
          content_english = data.isNotEmpty ? data[0]['content_english'] : null;
          content_tamil = data.isNotEmpty ? data[0]['content_tamil'] : null;
        });
        // });
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
    fetchUserInfo();
    setState(() {
      _locale_value = widget._locale.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(context, firstname, profile_url),
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
        title: Text(
          AppLocalizations.of(context)!.aboutpage,
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
                  _locale_value == 'en'
                      ? content_english.toString()
                      : content_tamil.toString(),
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
                        AppLocalizations.of(context)!.morevideos,
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
                              builder: (context) => VideosPage(),
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
                  child: Image.asset('assets/images/videos.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.morephotos,
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
