import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mnc/widgets/club_details/image_card.dart';
import 'package:mnc/widgets/club_details/video_card.dart';
import '../widgets/misc/toggle_button.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key,}) : super(key: key);
  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {

  bool isVideo = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButton(
                onTap: () {setState(() {isVideo =true;}); },
                height: 40, width: 80, label: 'Videos', topLeft: 20, bottomLeft: 20,
                color: (isVideo)? Colors.blue.shade100 : Colors.grey.shade200, textColor: (isVideo)? Colors.blue: Colors.grey,
              ),
              ToggleButton(
                  onTap: () {setState(() {isVideo =false;}); },
                  height: 40, width: 80, label: 'Photos', topRight: 20, bottomRight: 20,
                  color: (!isVideo)? Colors.blue.shade100 : Colors.grey.shade200, textColor: (!isVideo)? Colors.blue: Colors.grey
              ),
            ],
          ),
        ),
        body: (isVideo) ?
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('media').where('tag', isEqualTo: 'video').orderBy('timeStamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: Lottie.asset('animations/nothing.json'));}
            if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
            if(snapshot.data!.docs.isEmpty){return Center(child: Lottie.asset('animations/nothing.json'));}
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var videoUrl = data['videoUrl'];
                var headingText = data['heading'];
                var name = data['clubName'];
                var iconUrl = data['clubIcon'];
                return VideoCard(videoUrl: videoUrl, headingText: headingText, deleteId: '', clubName: '', onTap: (){}, iconUrl:iconUrl, name: name,);
              },
            );
          },
        ) :
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('media').where('tag', isEqualTo: 'photo').orderBy('timeStamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: Lottie.asset('animations/nothing.json'));}
            if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
            if(snapshot.data!.docs.isEmpty){return Center(child: Lottie.asset('animations/nothing.json'));}
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var imgUrl = data['imgUrl'];
                var caption = data['caption'];
                return ClubImageCard(imgUrl: imgUrl, caption: caption, clubName: 'widget.clubName', deleteId: '', mediaDeleteId: '', dim: [screenSize.width*0.32, screenSize.width*0.32],);
              },
            );
          },
        ),
      ),
    );
  }
}








