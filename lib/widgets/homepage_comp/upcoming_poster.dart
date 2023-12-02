import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mnc/widgets/misc/photo_upload.dart';
import '../../constants.dart';
import 'dart:io';
import '../../functions.dart';

class UpcomingPoster extends StatefulWidget {
  const UpcomingPoster({super.key});
  @override
  State<UpcomingPoster> createState() => _UpcomingPosterState();
}

class _UpcomingPosterState extends State<UpcomingPoster> {
  int currIndex =0;
  final CarouselController carouselController = CarouselController();
  File? compressedImageFile;
  String imageUrl = defaultImgUrl;
  bool isImageUploaded =false;
  bool isAdding =false;
  int cnt=0;
  late Stream<QuerySnapshot> imageStream;
  late Future<List<QueryDocumentSnapshot>> imageFuture;
  final TextEditingController timeText = TextEditingController();
  final TextEditingController dateText = TextEditingController();
  final TextEditingController venueText = TextEditingController();


  @override
  void initState() {
    super.initState();
    var firebase = FirebaseFirestore.instance;
    imageStream = firebase.collection("upComingImages").snapshots();
  }

  Future<void> upload(StateSetter updateState) async {
    if(isImageUploaded==true){
      updateState(() {
        isAdding=true;
      });
      String url = await getImageUrl(compressedImageFile!);
      setState(() {
        imageUrl= url;
      });
      DocumentReference doc = await FirebaseFirestore.instance.collection('upComingImages').add({
        'upcomingImageUrl' : imageUrl,
        'time' : timeText.text,
        'date' : dateText.text,
        'venue' : venueText.text,
      });
      DocumentReference doc1 = await addToTimeline("Added an upcoming poster.", imageUrl);
      String id  = doc.id;
      String id1 = doc1.id;
      await FirebaseFirestore.instance.collection('upComingImages').doc(id).update({'id' : id1});
      updateState(() {
        isAdding=false;
        compressedImageFile=null;
        isImageUploaded=false;
      });
      timeText.clear();
      dateText.clear();
      venueText.clear();
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upcoming", style: GoogleFonts.pottaOne(textStyle: TextStyle(fontSize: 22, color: Colors.grey[600], fontWeight: FontWeight.w200,))
              ),
              if (userName==admin) InkWell(
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
                                          PhotoUpload(onTap: () {imageUpload(state);}, imgHeight: screenSize.width*0.8, imgWidth: screenSize.width*0.6, radius: 20, compressedImageFile: compressedImageFile,),
                                          const Gap(20),
                                          TextWithTopic(title: 'Time : ', hintText: 'Enter time', controller: timeText),
                                          TextWithTopic(title: 'Date : ', hintText: 'Enter date', controller: dateText),
                                          TextWithTopic(title: 'Venue : ', hintText: 'Enter venue', controller: venueText),
                                        ],
                                      ),
                                    ),
                                    if(userName==admin)Padding(
                                      padding: const EdgeInsets.only(right: 85),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.green.shade400.withOpacity(0.5), width: 2),
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.green.shade500
                                          ),
                                          child: IconButton(
                                            onPressed: (){
                                              if(isImageUploaded==true) upload(state).then((value) => Navigator.pop(context));
                                            },
                                            color: Colors.white, icon: const Icon(Icons.check, size: 28,),)),
                                    )
                                  ],
                                ),
                              ],
                            );
                          });
                        }
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent[700],
                        borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.add,),
                  ),
                ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: imageStream,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset('animations/loading.json', height: 100);
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
              cnt=snapshot.data!.docs.length;
            return (cnt!=0)? CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: snapshot.data!.docs.length,
                options: CarouselOptions(
                    height: 250,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.55,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currIndex = index;
                      });
                    }),
                itemBuilder: (_,index,___){
                  DocumentSnapshot sliderImage = snapshot.data!.docs[index];
                  var timelineDeleteId = sliderImage['id'];
                  return InkWell(
                    onTap: (){
                      enlargeImg(context, screenSize.width*0.8, true, sliderImage['upcomingImageUrl'], admin, 'upComingImages', sliderImage.id, timelineDeleteId,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Time : ${sliderImage['time']}", style: GoogleFonts.varelaRound(textStyle: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Date : ${sliderImage['date']}", style: GoogleFonts.varelaRound(textStyle: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Venue : ${sliderImage['venue']}", style: GoogleFonts.varelaRound(textStyle: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600)),),
                              ),
                            ],
                          ), Container());
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(sliderImage['upcomingImageUrl'], fit: BoxFit.fill, height: 250, width: 200,)
                    ),
                  );
                }
            )
                : Lottie.asset('animations/nothing.json', height: 180);
          },
        )
      ],
    );
  }
}


class TextWithTopic extends StatelessWidget {
  const TextWithTopic({super.key, required this.title, required this.hintText, required this.controller});
  final String title;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(title, style: GoogleFonts.varelaRound(textStyle: TextStyle(color: Colors.grey[700], fontSize: 15, fontWeight: FontWeight.w600)),),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 34,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(fontSize:  15),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 0, style: BorderStyle.none),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue, width: 0, style: BorderStyle.none),
                ),
                // filled: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



