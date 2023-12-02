import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mnc/widgets/misc/person_card.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants.dart';

class SecretaryList extends StatelessWidget {
  const SecretaryList({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.6,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('team').where('tag', isEqualTo: 'Secretary').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {return const MyShimmer();}
          if (snapshot.hasError) {return Text('Error: ${snapshot.error}');}
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var cordiName = data['name'];
                var cordiImgUrl = data['imageUrl'];
                var cordiPOR = data['cordi_POR'];
                var timelineDeleteId = data['id'];
                var id = data.id;
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: PersonCard(
                    contHeight: 40,
                    contWidth: 40,
                    imgUrl: cordiImgUrl, deleteId: id,
                    name: cordiName,
                    position: cordiPOR, vertical: false, collName: 'team', user: admin, timelineDeleteId: timelineDeleteId,
                  )
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
  const MyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
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
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 13,
                              width: screenSize.width*0.7,
                              decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const Gap(4),
                            Container(
                              alignment: Alignment.centerLeft,
                              height: 13,
                              width: screenSize.width*0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
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

