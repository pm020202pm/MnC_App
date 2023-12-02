import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mnc/widgets/misc/button.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';


///////////////////implementing notification/////////////////////////
Future<bool> pushNotificationsAllUsers({required String title, required String body, icon}) async {
  FirebaseMessaging.instance.subscribeToTopic("allChannel");
  var response = await http.post(
    Uri.parse(Constants.BASE_URL),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key= ${Constants.KEY_SERVER}',
    },
    body: jsonEncode(
      <String, dynamic>{
        'priority': 'high',
        "to": "/topics/allChannel",
        "notification": <String, dynamic>{
          "title": title,
          "body": body,
          "android_channel_id": "basic",
        },
        "data": <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        }
      },
    ),
  );
  return true;
}

Future<String> downloadFile(String url, String fileName) async {
  final directory = await getApplicationCacheDirectory();
  final filePath = '${directory.path}/$fileName';
  final response  = await http.get(Uri.parse(url));
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

void showRemoteNotification(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    final largeIconPath = await downloadFile(defaultImgUrl, 'largeIcon');
    final bigPicturePath = await downloadFile(defaultImgUrl, 'bigPicture');
    final styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
    );

    if (android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
              styleInformation: styleInformation,
              largeIcon: FilePathAndroidBitmap(largeIconPath)
            ),
          )
      );
    }
  });
}

void requestPermission() async{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print("user granted permission");
  } else if(settings.authorizationStatus==AuthorizationStatus.provisional){
    print('user granted provisional permission');
  } else{
    print('user declined permission');
  }
}
////////////////////////notification ends////////////////////////////////////////




//////////////////////IMAGE UPLOAD STARTS////////////////////////////////////////
Future<File?> uploadImage() async {
  final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
    File compressedImage = await compressImage(imageFile.path);
    return compressedImage;
  }
}

Future<File> compressImage(String imagePath) async {
  final appDir = await getApplicationSupportDirectory();
  int strLength = imagePath.length;
  String format = imagePath.substring(strLength-3, strLength);
  CompressFormat imageFormat = (format=='png')? CompressFormat.png : (format=='eic')? CompressFormat.heic: CompressFormat.jpeg;
  final tempDir = Directory("${appDir.path}/temp");
  await tempDir.create(recursive: true);
  String fileName = path.basename(imagePath);
  File compressedImage = File('${tempDir.path}/img_$fileName');
  await FlutterImageCompress.compressAndGetFile(
    format:imageFormat,
    imagePath,
    compressedImage.path,
    quality: 20,
  );
  return compressedImage;
}


Future<String> getImageUrl(File compressedImage) async {
  Reference storageReference = FirebaseStorage.instance.ref().child('images').child(DateTime.now().microsecondsSinceEpoch.toString());
  UploadTask uploadTask = storageReference.putFile(compressedImage);
  String uploadedImage = await (await uploadTask).ref.getDownloadURL();
  return uploadedImage;
}
///////////////////////IMAGE UPLOAD ENDS/////////////////////////////////////////


void pushPage(BuildContext context, Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
}

Future<void> deleteEntity(String collectionName, String deleteId) async {
  await FirebaseFirestore.instance.collection(collectionName).doc(deleteId).delete();
}

void toast(String msg){
  Fluttertoast.showToast(msg: msg);
}

Future<DocumentReference> addToTimeline(String content, String image) async {
  DocumentReference doc = await FirebaseFirestore.instance.collection('timeline').add({
    'content': content,
    'image' : image,
    'timeStamp' : FieldValue.serverTimestamp(),
  });
  return doc;
}

Future<void> getCollectionLength(String collection) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collection).get();
  int collectionLength = querySnapshot.docs.length;
}

void enlargeImg(BuildContext context, double width, bool isImage, String imgUrl,String user, String collection, String deleteId,String timelineDeleteId, Widget widget, Widget widget2){
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade100, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300,
                      ),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if(isImage)ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              child: Image.network(imgUrl, width: width,)),
                          const Gap(17),
                          widget,
                          const Gap(15),
                        ],
                      ),
                    ),
                  ),
                  if(userName==user)Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red.shade400.withOpacity(0.5), width: 2),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red.shade50.withOpacity(0.9)
                              ),
                              child: IconButton(
                                onPressed: (){showWarning(context, 'Are you sure to remove?', (){ deleteEntity(collection, deleteId).then((value) => deleteEntity('timeline', timelineDeleteId)).then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context));});},
                                color: Colors.red[400], icon: const Icon(Icons.delete_forever, size: 28,),)),
                          Gap(10),
                          widget2
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        });
      }
  );
}

void showWarning(BuildContext context, String message, Function() function,){
  showModalBottomSheet<void>(
      backgroundColor: Colors.grey[100],
      context: context,
      builder: (BuildContext context){
        return StatefulBuilder(builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(message, style: GoogleFonts.varelaRound(textStyle: TextStyle(color: Colors.grey[700], fontSize: 20, fontWeight: FontWeight.w600)),),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Button(buttonText: 'Cancel', textColor: Colors.red.shade400, buttonBgColor: Colors.red.shade100, onPressed: (){Navigator.pop(context);}, height: 40, width: 70, borderRadius: 15, fontWeight: FontWeight.w700,),
                              const Gap(20),
                              Button(buttonText: 'Confirm', textColor: Colors.green.shade400, buttonBgColor: Colors.green.shade100, onPressed: function, height: 40, width: 70, borderRadius: 15, fontWeight: FontWeight.w700,),
                            ],
                          ),
                          const Gap(20)
                        ],
                      )
                  ),
                ]),
          );
        });
      });
}


