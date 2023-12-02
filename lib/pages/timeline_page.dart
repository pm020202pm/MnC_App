import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mnc/constants.dart';
import '../widgets/timelinepage_comp/timeline_card.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});
  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('timeline').orderBy('timeStamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
                var data = snapshot.data!.docs[index];
                Timestamp ts = data['timeStamp'];
                var imgUrl = data['image'];
                DateTime date = ts.toDate();
                String time = (date.hour>12)? '${date.hour-12}:${date.minute} PM' : (date.hour==0)? '12:${date.minute} AM': '${date.hour}:${date.minute} AM';
              return TimeLineCard(
                time: time, date: '${date.day} ${month[date.month-1]}', content: data['content'],
                childImg: (imgUrl!=defaultImgUrl && imgUrl!='')? Image.network(imgUrl, height: 35, width: 35, fit: BoxFit.cover,): Container(),
              );
            }
          );
        },
      ),
    );
  }
}



