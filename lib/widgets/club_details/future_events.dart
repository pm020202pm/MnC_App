import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mnc/functions.dart';
import 'package:mnc/widgets/misc/my_icon_button.dart';
import 'package:mnc/widgets/misc/topbar.dart';
import '../../constants.dart';
import '../misc/button.dart';
import '../misc/custom_textfield.dart';
import 'package:intl/intl.dart';

class FutureEvents extends StatefulWidget {
  const FutureEvents({Key? key, required this.clubName}) : super(key: key);
  final String clubName;

  @override
  State<FutureEvents> createState() => _FutureEventsState();
}

class _FutureEventsState extends State<FutureEvents> {
  String formattedTime = DateFormat.jm().format(DateTime.now());
  TextEditingController futureEvent = TextEditingController();
  int length=0;

  Future<void> addFutureEvent() async {
    if (futureEvent.text != '') {
      await FirebaseFirestore.instance.collection(userName).add({
        'events': futureEvent.text,
        'time': formattedTime,
        'tag': 'futureEvents'
      });
      futureEvent.clear();
    }
  }

  Future<void> getCollectionLength() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(widget.clubName).where('tag' , isEqualTo: 'futureEvents').get();
    int collectionLength = querySnapshot.docs.length;
    setState(() {
      length = (collectionLength).toInt();
    });
  }

  @override
  void initState() {
    getCollectionLength();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TopBar(
              heading: "Events", fntSize: 20, fntColor: Colors.blue,
              onTap: (){showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom:
                      MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MyTextField(
                            controller: futureEvent,
                            hintText: "Enter event info here",
                            boxHeight: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Button(
                            buttonText: "Add",
                            textColor: Colors.green[600],
                            buttonBgColor: Colors.green[100],
                            onPressed: () {
                              addFutureEvent().then(
                                      (value) => Navigator.pop(context)).then((value) => getCollectionLength());
                            },
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 60,
                            width: 80,
                            borderRadius: 20)
                      ],
                    ),
                  ),
                );
              });},
              user: widget.clubName
          ),
        ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(widget.clubName).where('tag', isEqualTo: 'futureEvents').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Lottie.asset('animations/nothing.json'));
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return (length!=0)? Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    var event = data['events'];
                    var id = data.id;
                    return Stack(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(24, 24, 8, 8),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow[600]),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(event, overflow: TextOverflow.ellipsis, maxLines: 5,),
                              ),
                            ),
                          ),
                          if(userName == widget.clubName)Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                                  child: MyIconButton(
                                    height: 30, width: 30, iconSize: 16, radius: 20, icon: Icons.delete_forever,
                                    onTap: () {
                                      showWarning(context, 'Are you sure to remove?',
                                          () => deleteEntity(userName, id).then((value) => Navigator.pop(context)).then((value) => getCollectionLength())
                                      );
                                    },
                                    backgroundColor: Colors.red.shade100.withOpacity(0.5),
                                    iconColor: Colors.red.shade500,
                                  )),
                        ]);
                  },
                ),
              )
                  : Center(child: Lottie.asset('animations/nothing.json'));
            },
          ),
        ),
      ),
    );
  }
}
