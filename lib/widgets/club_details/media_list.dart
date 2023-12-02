import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:mnc/functions.dart';
import 'package:mnc/widgets/club_details/image_card.dart';
import 'package:mnc/widgets/club_details/video_card.dart';
import '../../constants.dart';
import '../misc/button.dart';
import '../misc/custom_textfield.dart';
import '../misc/my_icon_button.dart';
import '../misc/photo_upload.dart';
import '../misc/toggle_button.dart';
import 'dart:io';

class MediaList extends StatefulWidget {
  const MediaList({Key? key, required this.clubName}) : super(key: key);
  final String clubName;
  @override
  State<MediaList> createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  TextEditingController heading = TextEditingController();
  TextEditingController videoUrl= TextEditingController();

  File? compressedImageFile;
  String imageUrl = defaultImgUrl;
  bool isImageUploaded =false;
  bool isAdding =false;
  bool isVideo = true;
  final TextEditingController caption = TextEditingController();
  int length = 0;

  Future<void> addVideo(StateSetter updateState) async {
    updateState(() {
      isAdding=true;
    });
    String iconUrl = '';
    String name = '';
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('clubProfile').doc(widget.clubName).get();
    if(document.exists){
      var ico = document.get('icon');
      var nam  = document.get('name');
      setState(() {
        iconUrl=ico;
        name = nam;
      });
    }
    DocumentReference doc = await FirebaseFirestore.instance.collection(userName).add({
      'clubName' : name,
      'clubIcon' : iconUrl,
      'heading' : heading.text,
      'videoUrl' : videoUrl.text,
      'tag' : 'video',
      'id' : '',
      'timeStamp' : FieldValue.serverTimestamp()
    });

    DocumentReference doc1 = await FirebaseFirestore.instance.collection('media').add({
      'clubName' : name,
      'clubIcon' : iconUrl,
      'heading' : heading.text,
      'videoUrl' : videoUrl.text,
      'tag' : 'video',
      'timeStamp' : FieldValue.serverTimestamp()
    });
    String id  = doc.id;
    String id1 = doc1.id;
    await FirebaseFirestore.instance.collection(userName).doc(id).update({'id' : id1});
    heading.clear();
    videoUrl.clear();
    updateState(() {
      isAdding=false;
    });
  }

  Future<void> uploadPhoto(StateSetter updateState) async {
    if(isImageUploaded==true){
      updateState(() {
        isAdding=true;
      });
      String url = await getImageUrl(compressedImageFile!);
      setState(() {
        imageUrl= url;
      });
      DocumentReference doc = await FirebaseFirestore.instance.collection(userName).add({
        'imgUrl' : imageUrl,
        'caption' : caption.text,
        'tag' : 'photo',
        'id' : '',
        'timeStamp' : FieldValue.serverTimestamp()
      });
      DocumentReference doc1 = await FirebaseFirestore.instance.collection('media').add({
        'imgUrl' : imageUrl,
        'caption' : caption.text,
        'tag' : 'photo',
        'timeStamp' : FieldValue.serverTimestamp()
      });
      String id  = doc.id;
      String id1 = doc1.id;
      await FirebaseFirestore.instance.collection(userName).doc(id).update({'id' : id1});

      updateState(() {
        isAdding=false;
        compressedImageFile=null;
        isImageUploaded=false;
      });
      caption.clear();
    }
  }

  Future<void> imageUpload(StateSetter updateState) async {
    File? compressedImgFile = await uploadImage();
    updateState(() {
      compressedImageFile = compressedImgFile;
      isImageUploaded = true;
    });
  }

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
              ToggleButton(onTap: () {setState(() {isVideo =true;});}, height: 40, width: 80, label: 'Videos', topLeft: 20, bottomLeft: 20, color: (isVideo)? Colors.blue.shade100 : Colors.grey.shade200, textColor: (isVideo)? Colors.blue: Colors.grey,),
              ToggleButton(onTap: () {setState(() {isVideo =false;});}, height: 40, width: 80, label: 'Photos', topRight: 20, bottomRight: 20, color: (!isVideo)? Colors.blue.shade100 : Colors.grey.shade200, textColor: (!isVideo)? Colors.blue: Colors.grey),
              const Gap(10),
              if(userName==widget.clubName)
                MyIconButton(
                  height: 35, width: 40, iconSize: 20, radius: 20, icon: Icons.video_call_outlined, 
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context){
                          return StatefulBuilder(
                            builder: (context, state)  {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      MyTextField(controller: heading, hintText: "Enter video title", boxHeight: 60,),
                                      const SizedBox(height: 20,),
                                      MyTextField(controller: videoUrl, hintText: "Paste youtube video url", boxHeight: 60,),
                                      (!isAdding) ?
                                      Button(
                                          padding: 15,
                                          buttonText: "Add",
                                          textColor: Colors.green[600], buttonBgColor: Colors.green[100],
                                          onPressed: (){
                                            String validUrl = (videoUrl.text.length>15) ?videoUrl.text.substring(0,15): 'abcdef';
                                            if(heading.text!='' && (validUrl=='https://www.you' || validUrl=='https://youtu.b')){
                                              addVideo(state).then((value) => Navigator.pop(context));
                                            }
                                            else if(heading.text=='') {
                                              toast('Please give a title to the video');
                                            }
                                            else{
                                              toast('Give a valid YouTube url');
                                              videoUrl.clear();
                                            }
                                          },
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          height: 50, width: 80, borderRadius: 20
                                      ):
                                      const CircularProgressIndicator()
                                    ]
                                ),
                              );
                            },
                          );
                        });
              },),
              const Gap(6),
              if(userName==widget.clubName)
                MyIconButton(
                height: 35, width: 40, iconSize: 18, radius: 20, icon: Icons.add_photo_alternate_outlined,
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return StatefulBuilder(builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  AlertDialog(
                                    backgroundColor: Colors.grey.shade300,
                                    content: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        PhotoUpload(onTap: () {imageUpload(state);}, imgHeight: screenSize.width*0.9, imgWidth: screenSize.width*0.8, radius: 20, compressedImageFile: compressedImageFile,),
                                        MyTextField(controller: caption, boxHeight: 100, maxLines: 3, hintText: 'Enter caption here...',)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 85),
                                    child: (!isAdding)?
                                    MyIconButton(
                                        height: 45, width:  45, iconSize: 28, radius: 30, icon: Icons.check,
                                        onTap: (){if(isImageUploaded==true) uploadPhoto(state).then((value) => Navigator.pop(context));}
                                    ):
                                        Container(
                                          height: 45,
                                            width:45,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: Colors.greenAccent[700]
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CircularProgressIndicator(color: Colors.white, backgroundColor: Colors.greenAccent[700], strokeWidth: 3,),
                                            ),
                                        )
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                      }
                  );
              },)
            ],
          ),
        ),
          body: (isVideo)?
          StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(widget.clubName).where('tag', isEqualTo: 'video').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: CircularProgressIndicator());}
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
                var mediaDeleteId = data['id'];
                var id = data.id;
                return VideoCard(videoUrl: videoUrl, headingText: headingText, deleteId: id, clubName: widget.clubName, onTap: (){deleteEntity(widget.clubName, id).then((value) => deleteEntity('media', mediaDeleteId)).then((value) => Navigator.pop(context));}, iconUrl: iconUrl, name: name,);
              },
            );
          },
          )
          : StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(widget.clubName).where('tag', isEqualTo: 'photo').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: CircularProgressIndicator());}
              if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
              if(snapshot.data!.docs.isEmpty){return Center(child: Lottie.asset('animations/nothing.json'));}
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  var imgUrl = data['imgUrl'];
                  var caption = data['caption'];
                  var mediaDeleteId = data['id'];
                  var id = data.id;
                  return ClubImageCard(imgUrl: imgUrl, caption: caption, clubName: widget.clubName, deleteId: id, mediaDeleteId: mediaDeleteId, dim: [screenSize.width*0.32, screenSize.width*0.32],);
                },
              );
            },
          ),
      ),
    );
  }
}








