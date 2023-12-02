import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../../constants.dart';


class InTouch extends StatefulWidget {
  InTouch({Key? key, required this.clubName}) : super(key: key);

  final String clubName;

  @override
  State<InTouch> createState() => _InTouchState();
}

class _InTouchState extends State<InTouch> {
  String facebook='';
  String instagram='';
  String youtube='';
  String discord='';
  String website='';
  String behance='';
  String flickr='';

  Future<void> getUrl() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('clubProfile').doc(widget.clubName).get();
    if(doc.exists){
      var face = doc.get('facebook');
      var insta = doc.get('instagram');
      var yout = doc.get('youtube');
      var disco = doc.get('discord');
      var websi = doc.get('website');
      var behan = doc.get('behance');
      var flic = doc.get('flickr');
      setState(() {
        facebook = face;
        instagram = insta;
        youtube = yout;
        discord = disco;
        website= websi;
        behance = behan;
        flickr = flic;
      });
    }
  }
  @override
  void initState() {
    getUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              if(facebook!='')IconButton(
                onPressed: (){
                  launchUrl(
                      Uri.parse(facebook),
                    mode: LaunchMode.externalApplication
                  );
                },
                icon: Lottie.asset('animations/facebook.json', width: 70)
              ),
              if(instagram!='')IconButton(
                onPressed: () {
                  launchUrl(
                      Uri.parse(instagram),
                      mode: LaunchMode.externalApplication
                  );
                },
                icon: Lottie.asset('animations/instagram.json', width: 70)
              ),
              if(youtube!='')IconButton(
                onPressed: (){
                  launchUrl(
                      Uri.parse(youtube),
                      mode: LaunchMode.externalApplication
                  );
                },
                icon: Lottie.asset('animations/youtube.json', width: 70)
              ),
              if(discord!='')IconButton(
                  onPressed: (){
                    launchUrl(
                        Uri.parse(discord),
                        mode: LaunchMode.externalApplication
                    );
                  },
                  icon: Lottie.asset('animations/youtube.json', width: 70)
              ),
            ],
          ),
        ],
      ),
    );
  }
}
