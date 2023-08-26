import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
class FutureEvents extends StatelessWidget {
  final String clubName;
  FutureEvents({Key? key, required this.clubName}) : super(key: key);
  int ind = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 280,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Future Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('$clubName-futureEvents')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Flexible(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index];
                          var event = data['events'];
                          var id = data.id;
                          var ind = index + 1;
                          return Stack(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 24, 8, 8),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.yellow[600]),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    event,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(12, 10, 0, 0),
                              child: Container(
                                alignment: Alignment.center,
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent[700],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  ind.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ]);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
