import 'dart:convert';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String authToken = '';

class BookModel {
  final String image;
  final String name_english;
  final String name_tamil;
  final String price;

  BookModel(this.image, this.name_english, this.name_tamil, this.price);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      json['image'],
      json['name_english'],
      json['name_tamil'],
      json['price'],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage(this._locale, {Key? key}) : super(key: key);

  final Locale? _locale;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FabCircularMenuPlusState> fabKey = GlobalKey();

  List<BookModel> allBooks = []; // Store the full list of users
  List<BookModel> displayBooks = []; // Displayed and filtered list

  // String profile_urls = '';
  String authToken = '';

  // final String logoutUrl =
  //     'https://atomsinnerwears.com/atomsinnerwears/api/logout';

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
      await uploadImageToApi(pickedImage.path);
      await fetchUserInfo();
    }

    // setState(() {
    //   _selectedImage = File(pickedImage.path);
    // });
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

  void fetchBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
      print(authToken);
    });
    final response = await http.get(
      Uri.parse('https://vgroups-api.pharma-sources.com/api/books/'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      // final List<dynamic> responseData = json.decode(response.body);
      // print("Books Data $responseData");
      final responseBody = utf8.decode(response.bodyBytes);
      print("Books Data decode $responseBody");

      final List<dynamic> responseData = json.decode(responseBody);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = true;

          allBooks =
              responseData.map((json) => BookModel.fromJson(json)).toList();
          displayBooks =
              List.from(allBooks); // Copy allUsers to displayItems initially

          print(allBooks);
        });
      });
    } else {
      print('Failed to load users');
    }
  }

  // Future<void> handleLogout(BuildContext context) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     authToken = prefs.getString('token')!;
  //   });
  //   try {
  //     final response = await http.post(
  //       Uri.parse(logoutUrl),
  //       headers: {
  //         'Authorization': 'Bearer $authToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('Logout Successful');
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => LoginScreen()),
  //       );
  //     } else {
  //       print('Logout failed');
  //     }
  //   } catch (error) {
  //     print('Error: $error');
  //   }
  // }

  // Future<void> fetchUserInfo() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     authToken = prefs.getString('token')!;
  //   });
  //   try {
  //     // Access the AuthProvider to get the authentication token

  //     final response = await http.get(
  //       Uri.parse('https://atomsinnerwears.com/atomsinnerwears/api/user'),
  //       headers: {
  //         'Authorization': 'Bearer $authToken',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // Parse the response body
  //       Map<String, dynamic> data = json.decode(response.body);

  //       setState(() {
  //         // Access the user information correctly
  //         profile_urls = data['user']['profile_url'];
  //       });
  //     } else {
  //       // Handle errors
  //       print('Failed to load user information');
  //     }
  //   } catch (e) {
  //     // Handle network errors
  //     print('Network error: $e');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchBooks();
    // print(widget._locale);
    print(allBooks);

    setState(() {
      _locale_value = widget._locale.toString();
    });
  }

  void updateList(String value) {
    isLoading = true;

    setState(() {
      if (value.isEmpty) {
        displayBooks = List.from(allBooks);
      } else {
        displayBooks = allBooks
            .where((book) =>
                book.name_english.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor('33A9DB'),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.repeated,
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
          AppLocalizations.of(context)!.bookpage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(context, firstname, profile_url),
      bottomNavigationBar: BottomNavBar(context, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Users',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Baloo Chettan 2',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 5,
              child: TextField(
                onChanged: (value) => updateList(value),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10.0),
                  filled: true,
                  fillColor: const Color(0xfffeeeee),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: AppLocalizations.of(context)!.search,
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoading == true
                  ? ListView.builder(
                      itemCount: displayBooks.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  // Display video thumbnail (consider caching with cached_network_image)
                                  Image.network(
                                    displayBooks[index].image,
                                    width: 80,
                                    height: 110,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      _locale_value == 'en'
                                          ? displayBooks[index].name_english
                                          : displayBooks[index].name_tamil,
                                      style: GoogleFonts.tiroTamil(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "Noto Sans Tamil",
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DecoratedBox(
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
                                width: 115,
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final Uri whatsappnumber =
                                        Uri.parse('http://wa.me/9514380984');

                                    _launchUrl(whatsappnumber);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ).merge(
                                    ButtonStyle(
                                      elevation: WidgetStateProperty.all(0),
                                    ),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.enquiry,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
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
                        strokeWidth:
                            2.0, // Adjust the thickness of the indicator
                        valueColor: AlwaysStoppedAnimation<Color>(
                          HexColor('368FF8'),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: TabButton(context, fabKey),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
