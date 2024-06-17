import 'dart:convert';
// import 'dart:io';
import 'package:Sivayogi_The_Guru/classes/language.dart';
import 'package:Sivayogi_The_Guru/classes/language_constants.dart';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:Sivayogi_The_Guru/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // File? _selectedImage;

  String firstname = '';
  String lastname = '';
  String email = '';
  String profile_url = '';
  String authToken = '';
  // late String refreshToken = '';
  // late DateTime tokenExpiry = DateTime.now();
  late bool isLoading = false;
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      return;
    } else {
      await uploadImageToApi(pickedImage.path);
      await fetchUserInfo();
    }

    // setState(() {
    //   _selectedImage = File(pickedImage.path);
    // });
  }

  @override
  void initState() {
    super.initState();

    fetchUserInfo();
  }

  Future<void> uploadImageToApi(String imagePath) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('https://vgroups-api.pharma-sources.com/api/user/'),
        // headers: {
        //   'Authorization': 'Bearer $authToken',
        // },
      );

      //header writing another way
      request.headers['Authorization'] = 'Bearer $authToken';
      request.files.add(
        await http.MultipartFile.fromPath('profile_pic', imagePath),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        await fetchUserInfo();
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //not movie container in top side
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor('368FF8'),
                HexColor('025CAF'),
              ], // Adjust colors as desired
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        title: Text(
          translation(context).profilepage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(context, firstname, profile_url),
      bottomNavigationBar: BottomNavBar(context, 3),
      body: Stack(
        children: [
          Positioned(
            child: Image.asset(
              "assets/images/profile_background.png",
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 140,
            top: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60,
              child: CircleAvatar(
                radius: 58,
                backgroundImage: profile_url.isNotEmpty
                    ? NetworkImage(profile_url)
                    : AssetImage('assets/images/placeholder.jpg')
                        as ImageProvider,
              ),
            ),
          ),
          // Positioned(
          //   left: 160,
          //   top: 130,
          //   child: Text(
          //     '$userName',
          //   ),
          // ),
          Positioned(
            width: MediaQuery.of(context).size.width * 1.15,
            height: MediaQuery.of(context).size.height * 0.32,
            child: IconButton(
              onPressed: () {
                _takePicture();
              },
              icon: Material(
                borderRadius: BorderRadius.circular(30),
                child: const Icon(
                  Icons.add_circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          isLoading == true
              ? Positioned.fill(
                  bottom: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 7,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.person_outlined, color: Colors.black),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              '$firstname $lastname'.toString(),
                              style: const TextStyle(
                                color: Color(0xFF4D4D4D),
                                fontSize: 15,
                                fontFamily: 'Baloo Chettan 2',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                // bottomsheet(_nameController, 'Enter your name');
                                // setState(() {
                                //   _nameController.text = "$firstname $lastname";
                                // });

                                bottomsheetname(
                                  _firstnameController,
                                  _lastnameController,
                                  AppLocalizations.of(context)!.firstnamehint,
                                  AppLocalizations.of(context)!.lastnamehint,
                                );
                                setState(() {
                                  _firstnameController.text = firstname;
                                  _lastnameController.text = lastname;
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 7,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            const Icon(Icons.email, color: Colors.black),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              '$email',
                              style: const TextStyle(
                                color: Color(0xFF4D4D4D),
                                fontSize: 15,
                                fontFamily: 'Baloo Chettan 2',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                bottomsheet(_emailController,
                                    translation(context).emailhint);
                                setState(() {
                                  _emailController.text = email;
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 7,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.language_outlined, color: Colors.black),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<Language>(
                                underline: const SizedBox(),
                                hint: Text(
                                  AppLocalizations.of(context)!.languages,
                                  style: TextStyle(
                                    color: Color(0xFF4D4D4D),
                                    fontSize: 15,
                                    fontFamily: 'Baloo Chettan 2',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale =
                                        await setLocale(language.languageCode);
                                    MyApp.setLocale(context, _locale);
                                  }
                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                        value: e,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              e.flag,
                                              style:
                                                  const TextStyle(fontSize: 30),
                                            ),
                                            Text(e.name)
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 7,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Icon(Icons.settings, color: Colors.black),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.settings,
                              style: TextStyle(
                                color: Color(0xFF4D4D4D),
                                fontSize: 15,
                                fontFamily: 'Baloo Chettan 2',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              HexColor('368FF8'),
                              HexColor('025CAF'),
                            ], // Customize your colors here
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.height * 0.18,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/', (Route<dynamic> route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ).merge(
                              ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                              ),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.logout,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
        ],
      ),
    );
  }

  Future<void> updatenamedata() async {
    final uri = Uri.parse('https://vgroups-api.pharma-sources.com/api/user/');
    try {
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode({
          'first_name': _firstnameController.text,
          'last_name': _lastnameController.text,
          // 'email': _emailController.text,
          // 'password': password,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Register succssfully....',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ProfilePage()));
      } else if (response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: 'Register succssfully....',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
      } else {
        print('A network error occurred');
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: 'enter valid  password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.of(context).pushNamed("register");
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
    }
  }

  Future<void> updateemaildata() async {
    final uri = Uri.parse('https://vgroups-api.pharma-sources.com/api/user/');
    try {
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode({
          'email': _emailController.text,
          // 'password': password,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Register succssfully....',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ProfilePage()));
      } else if (response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: 'Register succssfully....',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ),
        );
      } else {
        print('A network error occurred');
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: 'enter valid  password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.of(context).pushNamed("register");
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error: $error');
    }
  }

  void bottomsheet(controller, hintName) {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hintName,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            SizedBox(height: 20.0),
            TextField(
              maxLength: 25,
              controller: controller,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(
                      color: HexColor('025CAF'),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    updateemaildata();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(
                      color: HexColor('025CAF'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void bottomsheetname(controller1, controller2, hintName1, hintName2) {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hintName1,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            SizedBox(height: 20.0),
            TextField(
              maxLength: 25,
              controller: controller1,
            ),
            SizedBox(height: 20.0),
            Text(hintName2,
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
            SizedBox(height: 20.0),
            TextField(
              maxLength: 25,
              controller: controller2,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(
                      color: HexColor('025CAF'),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    updatenamedata();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(
                      color: HexColor('025CAF'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
