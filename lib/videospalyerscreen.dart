import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ignore: must_be_immutable
class VideoPlayerScreen extends StatefulWidget {
  String youtubeUrl;

  VideoPlayerScreen(this.youtubeUrl, {super.key});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  final bool _isPlayerReady = false;
  late String videoId;

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        controlsVisibleAtStart: true,
        hideControls: false,
        showLiveFullscreenButton: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      // setState(() {});
    }
  }

  @override
  void deactivate() {
    /// Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _controller.reset();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 400,
            color: Colors.blue,
            child: VisibilityDetector(
              key: const Key("unique key"),
              onVisibilityChanged: (info) {
                if (info.visibleFraction == 0) {
                  _controller.pause();
                } else {
                  _controller.value.isPlaying
                      ? _controller.play()
                      : _controller.pause();
                }
              },
              child: YoutubePlayerBuilder(
                onExitFullScreen: () {
                  /// After leaving fullscreen, the player forces portraitUp. The behaviour is overridden by this.
                  SystemChrome.setPreferredOrientations(
                      DeviceOrientation.values);
                },
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  topActions: <Widget>[
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        _controller.metadata.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                  onReady: () {
                    _controller.addListener(listener);
                  },
                  onEnded: (data) {},
                ),
                builder: (context, player) => Scaffold(
                  key: _scaffoldKey,
                  body: ListView(
                    children: [
                      player,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
