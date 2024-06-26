import 'dart:convert';
import 'package:Sivayogi_The_Guru/image_view.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  String authToken = '';
  List<String> imageUrls = [];

  Future<void> fetchaboutimageInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authToken = prefs.getString('token')!;
    });
    try {
      final response = await http.get(
        Uri.parse('https://vgroups-api.pharma-sources.com/api/about-assets/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);
        print('Parsed Data about data: $data');

        List<String> urls =
            data.map((item) => item['image']).cast<String>().toList();

        print('Parsed Data urls data: $urls');
        setState(() {
          imageUrls = urls;
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
    fetchaboutimageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gallery")),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.all(1),
        itemCount: imageUrls.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.all(0.5),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewPage(
                    imageUrl: imageUrls[index],
                  ),
                ),
              ),
              child: Hero(
                tag: imageUrls[index],
                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
