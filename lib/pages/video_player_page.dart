import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlay extends StatefulWidget {
  VideoPlay({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late YoutubePlayerController _controller;
  late String myVideoId;
  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    setState(() {
      myVideoId = videoId!;
    });
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
            autoPlay: true
        )
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: YoutubePlayer(
            controller: _controller,
            width: size.width,
          ),
        ),
      ),
    );
  }
}
