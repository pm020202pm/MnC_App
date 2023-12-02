import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mnc/constants.dart';
import 'package:mnc/widgets/misc/photo_upload.dart';
import 'package:mnc/widgets/teamspage_comp/teams_list.dart';
import '../functions.dart';
import '../widgets/misc/button.dart';
import 'dart:io';
import '../widgets/teamspage_comp/secretary_list.dart';
import '../widgets/misc/topbar.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);
  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  TextEditingController cordiName = TextEditingController();
  TextEditingController cordiResponsibility = TextEditingController();
  File? compressedImageFile;
  String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/traveldost-f6a2d.appspot.com/o/images%2Fprofile.jpg?alt=media&token=6d6b2bfd-068d-44a4-9927-4ee3963c6e1a';
  bool isImageUploaded =false;
  int value=0;
  List<String> collection=['GenSec', 'InstSec', 'Coordinator', 'Secretary'];
  bool isAdding =false;


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 14, 14, 10),
                child: Text('Meet The Team', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
              ),
              TopBar(heading: "General Secretary", onTap: (){showBottomModal(0);}, user: admin, fntColor: Colors.grey[600], fntSize: 15,),
              Container(
                alignment: Alignment.center,
                width: 130,
                  child: const TeamsList(por: 'GenSec')),
              TopBar(heading: "Institute Secretary", onTap: (){showBottomModal(1);}, user: admin, fntColor: Colors.grey[600], fntSize: 15,),
              const TeamsList(por: 'InstSec'),
              TopBar(heading: "Coordinator", onTap: (){showBottomModal(2);}, user: admin, fntColor: Colors.grey[600], fntSize: 15,),
              const TeamsList(por: 'Coordinator'),
              TopBar(heading: "Council Secretary", onTap: (){showBottomModal(3);}, user: admin, fntColor: Colors.grey[600], fntSize: 15,),
              const SecretaryList(),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomModal(int index){
    setState(() {
      value = index;
    });
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                    PhotoUpload(onTap: () {imageUpload(state);}, imgHeight: 80, imgWidth: 80, radius: 20, compressedImageFile: compressedImageFile,),
                                    const SizedBox(width: 12,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            style: const TextStyle(
                                                fontSize: 15),
                                            controller: cordiName,
                                            decoration: const InputDecoration(
                                              border: InputBorder
                                                  .none,
                                              labelStyle: TextStyle(
                                                  fontSize: 15),
                                              hintText: "Enter name",
                                              hintStyle: TextStyle(
                                                  fontSize: 15),
                                            ),
                                          ),
                                          if(value!=0)TextField(
                                            style: const TextStyle(fontSize: 15),
                                            controller: cordiResponsibility,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              labelStyle: TextStyle(fontSize: 15),
                                              hintText: "Enter responsibility",
                                              hintStyle: TextStyle(fontSize: 15),
                                            ),
                                          ),
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
                                addTeam(state).then((value) =>
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

  Future<void> addTeam(StateSetter updateState) async {
    if(cordiName.text!=''){
      if(isImageUploaded==true){
        updateState(() {
          isAdding=true;
        });
        String url = await getImageUrl(compressedImageFile!);
        setState(() {
          imageUrl= url;
        });
      }
      DocumentReference doc = await FirebaseFirestore.instance.collection('team').add({
        'name': cordiName.text,
        'imageUrl' : imageUrl,
        'cordi_POR' : cordiResponsibility.text,
        'tag' : collection[value],
        'id': ''
      });

      DocumentReference doc1 = await addToTimeline("Added ${cordiName.text} in MnC Team.", imageUrl);
      String id  = doc.id;
      String id1 = doc1.id;
      await FirebaseFirestore.instance.collection('team').doc(id).update({'id' : id1});
      updateState(() {
        isAdding=false;
        compressedImageFile=null;
        isImageUploaded=false;
        imageUrl = defaultImgUrl;
      });
      cordiName.clear();
      cordiResponsibility.clear();
    }
  }

  Future<void> imageUpload(StateSetter updateState) async {
    File? compressedImgFile = await uploadImage();
    updateState(() {
      compressedImageFile = compressedImgFile;
      isImageUploaded = true;
    });
  }
}








