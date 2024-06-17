import 'dart:convert';
import 'package:Sivayogi_The_Guru/model/video_model.dart';
import 'package:Sivayogi_The_Guru/videospalyerscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  String authToken = '';
  List<VideoItem> videos = [];

  @override
  void initState() {
    super.initState();
    fetchaboutimageInfo();
  }

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
        final responseBody = utf8.decode(response.bodyBytes);
        print("Books Data decode $responseBody");
        List<dynamic> data = json.decode(responseBody);
        setState(() {
          videos = data
              .map((item) => VideoItem(
                    videoUrl: item['video_url'] ?? '',
                    title: item['video_name'] ?? 'No Title',
                    thumbnailUrl: item['image'] ?? '',
                  ))
              .toList();
        });
      } else {
        print('Failed to load user information');
      }
    } catch (e) {
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video Player'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: videos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final videoItem = videos[index];
                return InkWell(
                  onTap: () {
                    if (videoItem.videoUrl.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VideoPlayerScreen(videoItem.videoUrl),
                        ),
                      );
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.network(
                            videoItem.thumbnailUrl,
                            width: 150,
                            height: 100,
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              videoItem.title,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
