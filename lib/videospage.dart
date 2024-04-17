import 'package:flutter/material.dart';
import 'package:v_group/model/video_model.dart';
import 'package:v_group/videospalyerscreen.dart';
import 'package:video_player/video_player.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final List<VideoItem> videos = [
    VideoItem(
      videoUrl: 'https://youtu.be/nrwc28d5f8M?si=fzqOltXpAv3hX7z8',
      title: 'Rick Astley - Never Gonna Give You Up',
      thumbnailUrl:
          'https://media.licdn.com/dms/image/sync/D5627AQET_YqFJyOT4w/articleshare-shrink_800/0/1711913377752?e=2147483647&v=beta&t=ZKNja_41QD3ZuSSw3bbRl9plbon8NybzGTbEjnUlALc',
    ),
    // Add more video items
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video Player'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final videoItem = videos[index];
          return InkWell(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(videoItem.videoUrl),
              ),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Display video thumbnail (consider caching with cached_network_image)
                    Image.network(
                      videoItem.thumbnailUrl,
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child:
                          Text(videoItem.title, style: TextStyle(fontSize: 16)),
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
