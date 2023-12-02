import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';
import '../misc/person_card.dart';
class TeamsList extends StatelessWidget {
  const TeamsList({super.key, required this.por});
  final String por;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (por!='GenSec')? 175:185,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('team').where('tag', isEqualTo: por).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {return MyShimmer(itemCount: (por!='GenSec')? 5:1,);}
          if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var cordiName = data['name'];
                var cordiImgUrl = data['imageUrl'];
                var cordiPOR = data['cordi_POR'];
                var timelineDeleteId = data['id'];
                var id = data.id;
                return PersonCard(
                  contHeight: (por!='GenSec')?80:90, 
                  contWidth: (por!='GenSec')? 80:90, 
                  imgUrl: cordiImgUrl,  deleteId: id,
                  name: cordiName,
                  position: (por!='GenSec')? cordiPOR: 'General Secretary', vertical: true, collName: 'team', user: admin, timelineDeleteId: timelineDeleteId,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class MyShimmer extends StatelessWidget {
  const MyShimmer({super.key, required this.itemCount});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.25),
            highlightColor: Colors.white.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 13,
                            width: 75,
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          const Gap(4),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 13,
                            width: 65,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
