import 'dart:convert';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v_group/costoms.dart';

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
        Uri.parse('http://vgroups-api.pharma-sources.com/api/sliders/'),
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
        title: const Text(
          'Profile page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(context),
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
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10.0,
                      bottom: 5.0,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        'வல்லரசு கட்சி என்ற குடும்பத்திற்கு உங்கள்ஒவ்வொருவரையும் அன்புடனும் மிகுந்த மகிழ்ச்சியுடனும் மற்றும் உற்சாகத்துடனும் வரவேற்கின்றோம். நாம் இன்று இங்கு கூடிவந்திருப்பது வெறும் தனி நபர்களாக மட்டும் அல்ல, மாறாக ஒரு சிறந்த எதிர்காலம், வலுவான தேசம் மற்றும் வளமான சமுதாயத்திற்கான பகிரப்பட்ட பார்வையால்உந்தப்பட்ட ஒரு ஐக்கிய சக்தியாக !\nஇந்த சவாலான காலங்களில், நமது அரசியல் கட்சி நம்பிக்கை மற்றும் மாற்றத்தின் கலங்கரை விளக்கமாக நிற்கிறது. ஒற்றுமையின் சக்தி, பன்முகத்தன்மையின் வலிமை மற்றும் கூட்டு நடவடிக்கையின் திறனை நாங்கள் நம்புகிறோம். ஒன்றாக, நமது சமூகம், நமது மாநிலம் மற்றும் நமது தேசத்தில் நேர்மறையான தாக்கத்தை ஏற்படுத்த நாங்கள்உறுதிபூண்டுள்ளோம்.',
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
