import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class RecPerformance extends StatefulWidget {
  const RecPerformance({Key? key}) : super(key: key);

  @override
  State<RecPerformance> createState() => _RecPerformanceState();
}

class _RecPerformanceState extends State<RecPerformance> {
  late YoutubePlayerController _controller;
  String videoUrl = "https://youtu.be/v42MpbFhq8s";
  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
            autoPlay: false
        )
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200]
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text('Recent Performances', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,),
              )
            ],
          ),
        ));
  }
}
