import 'dart:convert';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:v_group/costoms.dart';

String authToken = '';

class BookModel {
  final String image;
  final String name;
  final String price;

  BookModel(this.image, this.name, this.price);

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      json['image'],
      json['name'],
      json['price'],
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<FabCircularMenuPlusState> fabKey = GlobalKey();

  List<BookModel> allBooks = []; // Store the full list of users
  List<BookModel> displayBooks = []; // Displayed and filtered list
  bool isLoading = false;
  // String profile_urls = '';
  String authToken = '';

  // final String logoutUrl =
  //     'https://atomsinnerwears.com/atomsinnerwears/api/logout';

  void fetchBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
      print(authToken);
    });
    final response = await http.get(
      Uri.parse('http://vgroups-api.pharma-sources.com/api/books/'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
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

    fetchBooks();
    print(allBooks);
    // fetchUserInfo();
  }

  void updateList(String value) {
    isLoading = true;

    setState(() {
      if (value.isEmpty) {
        displayBooks = List.from(allBooks);
      } else {
        displayBooks = allBooks
            .where(
                (book) => book.name.toLowerCase().contains(value.toLowerCase()))
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
        title: const Text(
          'User Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(context),
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
                  hintText: 'Search',
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
                      itemBuilder: (context, index) => Container(
                        height: 120,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          // const Color(0xfffeeeee)
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 63, 62, 62)
                                  .withOpacity(0.50),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListTile(
                                leading: Image.network(
                                  displayBooks[index].image,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                // dense: true,
                                title: Text(
                                  displayBooks[index].name,
                                  style: TextStyle(fontSize: 14),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    displayBooks[index].price,
                                    style: TextStyle(fontSize: 12),
                                  ),
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
                                  width: 90,
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
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                    ),
                                    child: const Text(
                                      'Enquiry',
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
