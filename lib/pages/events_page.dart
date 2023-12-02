import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../functions.dart';
import '../constants.dart';
import '../widgets/misc/custom_textfield.dart';
import '../widgets/misc/my_icon_button.dart';
import 'dart:io';
import '../widgets/misc/photo_upload.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});
  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool isEvents = true;
  File? compressedImageFile;
  bool isImageUploaded = false;
  bool isAdding = false;
  String imageUrl = defaultImgUrl;
  final TextEditingController caption = TextEditingController();

  Future<void> uploadPhoto(StateSetter updateState) async {
    if (isImageUploaded == true) {
      updateState(() {
        isAdding = true;
      });
      String url = await getImageUrl(compressedImageFile!);
      setState(() {
        imageUrl = url;
      });
      DocumentReference doc= await FirebaseFirestore.instance.collection('events').add({
        'imgUrl': imageUrl,
        'caption': caption.text,
        'tag': 'event',
        'timeStamp' : FieldValue.serverTimestamp()
      });
      DocumentReference doc1 = await addToTimeline("Added an event.", imageUrl);
      String id  = doc.id;
      String id1 = doc1.id;
      await FirebaseFirestore.instance.collection('events').doc(id).update({'id' : id1});
      updateState(() {
        isAdding = false;
        compressedImageFile = null;
        isImageUploaded = false;
      });
      caption.clear();
    }
  }

  Future<void> addToPastEvents(String imgUrl, String caption, String deleteId) async {
    await FirebaseFirestore.instance.collection('pastEvents').add({
      'imgUrl': imgUrl,
      'caption': caption,
      'tag': 'pastEvent',
      'timeStamp' : FieldValue.serverTimestamp()
    }).then((value) => deleteEntity('events', deleteId));
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              height: 47,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: (isEvents) ? Colors.blue[100] : Colors.grey[200],
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isEvents = true;
                  });
                },
                child: Text("EVENTS", style: TextStyle(color: (isEvents) ? Colors.blue : Colors.grey[500], fontWeight: FontWeight.w900, fontSize: 14)),
              ),
            ),
            Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              height: 47,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: (!isEvents) ? Colors.blue[100] : Colors.grey[200],
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isEvents = false;
                  });
                },
                child: Column(
                  children: [
                    Text("PAST", style: TextStyle(color: (!isEvents) ? Colors.blue : Colors.grey[500], fontWeight: FontWeight.w900, fontSize: 14,)),
                    Text("EVENTS", style: TextStyle(color: (!isEvents) ? Colors.blue : Colors.grey[500], fontWeight: FontWeight.w800, fontSize: 8)),
                  ],
                ),
              ),
            ),
            const Gap(10),
            if (userName == admin && isEvents)
              MyIconButton(
                height: 35, width: 40, iconSize: 18, radius: 20,
                icon: Icons.add_photo_alternate_outlined,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        PhotoUpload(
                                          onTap: () {
                                            imageUpload(state);
                                          },
                                          imgHeight: screenSize.width * 0.9,
                                          imgWidth: screenSize.width * 0.8,
                                          radius: 20,
                                          compressedImageFile:
                                              compressedImageFile,
                                        ),
                                        MyTextField(
                                          controller: caption,
                                          boxHeight: 100,
                                          maxLines: 3,
                                          hintText: 'Enter details here...',
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 85),
                                    child: MyIconButton(
                                        height: 45,
                                        width: 45,
                                        iconSize: 28,
                                        radius: 30,
                                        icon: Icons.check,
                                        onTap: () {uploadPhoto(state).then((value) => Navigator.pop(context));}),
                                  )
                                ],
                              ),
                            ],
                          );
                        });
                      });
                },
              ),
          ],
        ),
      ),
      body: SafeArea(
          child:
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection((isEvents)? 'events': 'pastEvents').orderBy('timeStamp', descending: true).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: Lottie.asset('animations/nothing.json'));}
                    if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
                    if(snapshot.data!.docs.isEmpty){return Center(child: Lottie.asset('animations/nothing.json'));}
                    return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
                              var imgUrl = data['imgUrl'];
                              var caption = data['caption'];
                              var timelineDeleteId = data['id'];
                              var id = data.id;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    if (imgUrl != defaultImgUrl)
                                      InkWell(
                                        onTap: () {
                                          enlargeImg(context, screenSize.width * 0.8, true, imgUrl, admin, (isEvents) ? 'events': 'pastEvents', id, timelineDeleteId,
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(
                                                caption,
                                                style: GoogleFonts.varelaRound(
                                                    textStyle: TextStyle(
                                                      color:
                                                      Colors.grey[700],
                                                      fontSize:
                                                      15,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    )),
                                              ),
                                            ),
                                              (isEvents) ?
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.green.shade400.withOpacity(0.5), width: 2),
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Colors.green.shade50.withOpacity(0.9)
                                                ),
                                                child: IconButton(
                                                  onPressed: (){showWarning(context, 'Are you sure to add to past events?', (){ addToPastEvents(imgUrl, caption, id).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));});},
                                                  color: Colors.green[400], icon: const Icon(Icons.fast_forward_rounded, size: 28,),)):
                                              Container()
                                          );
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.only(bottomRight: (caption=='')? const Radius.circular(10) : const Radius.circular(0),bottomLeft: (caption=='')? const Radius.circular(10) : const Radius.circular(0),topRight: const Radius.circular(10), topLeft: const Radius.circular(10)),
                                            child: Image.network(
                                              imgUrl,
                                              width: screenSize.width * 0.7,
                                            )),
                                      ),
                                    if(caption!='')InkWell(
                                      onTap: () {
                                        if(imgUrl==defaultImgUrl) {
                                          enlargeImg(context, screenSize.width * 0.8,false, imgUrl, admin, (isEvents)? 'events': 'pastEvents', id, timelineDeleteId,
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              caption,
                                              style: GoogleFonts.varelaRound(
                                                  textStyle: TextStyle(
                                                    color:
                                                    Colors.grey[700],
                                                    fontSize:
                                                    15,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  )),
                                            ),
                                          ),
                                            (isEvents) ?
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.green.shade400.withOpacity(0.5), width: 2),
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: Colors.green.shade50.withOpacity(0.9)
                                              ),
                                              child: IconButton(
                                                onPressed: (){showWarning(context, 'Are you sure to add to past events?', (){ addToPastEvents(imgUrl, caption, id).then((value) => Navigator.pop(context));});},
                                                color: Colors.green[400], icon: const Icon(Icons.fast_forward_rounded, size: 28,),)) :
                                            Container()
                                        );
                                        }
                                      },
                                      child: Container(
                                          width: screenSize.width * 0.7,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: (imgUrl == defaultImgUrl)
                                                  ? const Radius.circular(10)
                                                  : const Radius.circular(0),
                                              bottomLeft:
                                                  const Radius.circular(10),
                                              topRight: (imgUrl == defaultImgUrl)
                                                  ? const Radius.circular(10)
                                                  : const Radius.circular(0),
                                              bottomRight: const Radius.circular(10),
                                            ),
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(caption,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey.shade700,
                                                    fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1),
                                          )),
                                    ),
                                  ],
                                ),
                              );
                              },
                    );
                    },
              )
      ),
    );
  }
}
