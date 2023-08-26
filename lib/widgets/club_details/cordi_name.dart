import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mnc/widgets/card.dart';
class CordiName extends StatefulWidget {
  final String clubName;
  const CordiName({Key? key, required this.clubName}) : super(key: key);

  @override
  State<CordiName> createState() => _CordiNameState();
}

class _CordiNameState extends State<CordiName> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('${widget.clubName}-cordi')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                childAspectRatio: 2.45
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];
                var cordiName = data['cordi'];
                var cordiImgUrl = data['imageUrl'];
                var id = data.id;
                return IntroCard(imageUrl: cordiImgUrl, name: cordiName, position: 'Coordinator' , imageHeight: 40, imageWidth: 40, cardHeight: 55, fontSize: 12,);
              },
            );
          },
        ),
      ),
    );
  }
}
