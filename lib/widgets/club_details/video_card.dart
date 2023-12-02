import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mnc/pages/video_player_page.dart';
import 'package:mnc/widgets/misc/my_icon_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../constants.dart';
import '../../functions.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({Key? key, required this.videoUrl, required this.headingText, required this.deleteId, required this.clubName, this.onTap, required this.iconUrl, required this.name}) : super(key: key);
  final String videoUrl;
  final String iconUrl;
  final String name;
  final String headingText;
  final String deleteId;
  final String clubName;
  final Function()? onTap;

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late String myVideoId;

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    setState(() {
      myVideoId = videoId!;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoPlay(videoUrl: widget.videoUrl)));},
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: SizedBox(
                height: 180,
                  child: Image.network(YoutubePlayer.getThumbnail(videoId: myVideoId), width: size.width*0.9, fit: BoxFit.cover,)),),
          Container(
            width: size.width*0.9,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                color: Colors.grey.shade300,
            ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                      ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(widget.iconUrl, height: 40,))
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:size.width*0.6,
                            child: Text(widget.headingText, style: TextStyle(fontWeight: FontWeight.w700, color: Colors.grey[700], fontSize: 15), maxLines: 2, overflow: TextOverflow.clip)
                        ),
                        Text(widget.name, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[600], fontSize: 11), maxLines: 2, overflow: TextOverflow.clip),
                      ],
                    ),
                   const Spacer(),
                    if(userName==widget.clubName)MyIconButton(height: 40, width: 40, iconSize: 22, backgroundColor: Colors.red.shade100, iconColor: Colors.red, radius: 20, icon: Icons.delete_forever_outlined, onTap: (){showWarning(context, 'Are you sure to remove?', widget.onTap!);}, )
                  ],
                ),
              )),
        ],
        ),
      ),
    );
  }
}

