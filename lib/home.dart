import 'dart:convert';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderModel {
  final String image;

  SliderModel(this.image);

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      json['image'],
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String authToken = '';
  List<dynamic> _imageUrls = [];

  String firstname = '';
  String lastname = '';
  String email = '';
  String profile_url = '';

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

  List imagesList = [
    {"id": 1, "image": 'assets/images/slider1.png'},
    {"id": 2, "image": 'assets/images/slider1.png'},
    {"id": 3, "image": 'assets/images/slider1.png'},
  ];

  Future<void> fetchImages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
    });
    try {
      final response = await http.get(
        Uri.parse('https://vgroups-api.pharma-sources.com/api/sliders/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _imageUrls = data.map((item) => item['image']).toList();
        });
      } else {
        throw Exception('Failed to load images: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching images: $e');
      // Handle error (e.g., show error message to user)
    }
  }

  @override
  void initState() {
    fetchImages();
    fetchUserInfo();
    super.initState();
  }

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('FFFFFF'),
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
          AppLocalizations.of(context)!.homepage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(context, firstname, profile_url),
      bottomNavigationBar: BottomNavBar(context, 0),
      body: _imageUrls.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                CarouselSlider.builder(
                  itemCount: _imageUrls.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Image.network(
                      _imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                  options: CarouselOptions(
                    height: 300.0,
                    aspectRatio: 5.0,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10.0,
                      bottom: 5.0,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        AppLocalizations.of(context)!.home_content,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          wordSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
    );
  }
}
