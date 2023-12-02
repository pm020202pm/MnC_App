import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mnc/widgets/misc/person_card.dart';
import 'package:mnc/widgets/misc/topbar.dart';
import 'dart:io';
import '../../constants.dart';
import '../../functions.dart';
import '../misc/button.dart';
import '../misc/photo_upload.dart';

class ClubCordiList extends StatefulWidget {
  const ClubCordiList({Key? key, required this.clubName, required this.name}) : super(key: key);
  final String clubName;
  final String name;

  @override
  State<ClubCordiList> createState() => _ClubCordiListState();
}

class _ClubCordiListState extends State<ClubCordiList> {
  TextEditingController cordiName = TextEditingController();
  File? compressedImageFile;
  late String imageUrl = defaultImgUrl;
  bool isImageUploaded =false;
  bool isAdding =false;
  int length=0;
  double height=0;



  @override
  void initState() {
    getCollectionLength();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.topCenter,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.blue.shade200, Colors.green.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(heading: 'Meet The Team', onTap: () {  showBottomModal();}, fntSize: 20, fntColor: Colors.black, user: widget.clubName ,),
            (length!=0)? Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(widget.clubName).where('tag', isEqualTo: 'cordi').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent:55,
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index];
                        var cordiName = data['cordi'];
                        var cordiImgUrl = data['imageUrl'];
                        var timelineDeleteId = data['id'];
                        var id = data.id;
                        return PersonCard(
                            contHeight: 40, contWidth:  40,
                            imgUrl: cordiImgUrl, name: cordiName, position: 'Coordinator',
                            deleteId: id, vertical: false, collName: widget.clubName, user: widget.clubName, timelineDeleteId: timelineDeleteId ,
                        );
                      },
                    ),
                  );
                },
              ),
            )
                : Lottie.asset('animations/pumpkin.json', height: 118)
          ],
        )),
    );
  }
  Future<void> addCordis(StateSetter updateState) async {
    if(isImageUploaded==true){
      updateState(() {
        isAdding=true;
      });
      String url = await getImageUrl(compressedImageFile!);
      setState(() {
        imageUrl= url;
      });
    }
    DocumentReference doc = await FirebaseFirestore.instance.collection(userName).add({
      'cordi': cordiName.text,
      'imageUrl' : imageUrl,
      'tag' : 'cordi'
    });

    DocumentReference doc1 = await addToTimeline("Added ${cordiName.text} as Coordinator in ${widget.name}.", imageUrl);
    String id  = doc.id;
    String id1 = doc1.id;
    await FirebaseFirestore.instance.collection(userName).doc(id).update({'id' : id1});
    getCollectionLength();
    updateState(() {
      isAdding=false;
      compressedImageFile=null;
      isImageUploaded=false;
      imageUrl = defaultImgUrl;
    });
    cordiName.clear();
  }

  ////UPLOAD IMAGE
  Future<void> uploadImage(StateSetter updateState) async {
    final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      File compressedImage = await compressImage(imageFile.path);
      updateState(() {
        compressedImageFile = compressedImage;
        isImageUploaded = true;
      });
    }
  }

  Future<void> getCollectionLength() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(widget.clubName).where('tag' , isEqualTo: 'cordi').get();
    int collectionLength = querySnapshot.docs.length;
    setState(() {
      length = (collectionLength*0.5+0.5).toInt();
      int len = (length!=0)? length-1: 0;
      height=175+(70*(len).toDouble());
    });
  }

  void showBottomModal(){
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom),
              child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius
                                    .circular(22),
                              ),
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    PhotoUpload(onTap: () {uploadImage(state);}, imgHeight: 80, imgWidth: 80, radius: 20, compressedImageFile: compressedImageFile,),
                                    const Gap(12),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            style: const TextStyle(fontSize: 15),
                                            controller: cordiName,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              labelStyle: TextStyle(fontSize: 15),
                                              hintText: "Enter name",
                                              hintStyle: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          const Gap(5),
                                          Text('Coordinator',
                                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.grey[500]),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Gap(7),
                          Button(
                              buttonText: (isAdding)? "Adding..": "Add",
                              textColor: Colors.green[600],
                              buttonBgColor: Colors.green[100],
                              onPressed: () {
                                addCordis(state).then((value) =>
                                    Navigator.pop(context));
                              },
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              height: 100,
                              width: 65,
                              borderRadius: 20),
                        ],
                      ),
                    ),
                  ]),
            );
          });
        });
  }
}




