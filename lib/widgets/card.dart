import 'package:flutter/material.dart';
class IntroCard extends StatelessWidget {
  IntroCard({Key? key, required this.imageUrl, required this.name, this.position, required this.imageHeight, required this.imageWidth, required this.cardHeight}) : super(key: key);
  final String imageUrl;
  final String name;
  final double imageHeight;
  final double imageWidth;
  final double cardHeight;
  late String? position;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Container(
        alignment: Alignment.centerLeft,
        height: cardHeight,
        // width: (size.width/2.1),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Row(
            // mainAxisSize: MainAxisSize.,
            children: [
              Container(
                height: imageHeight,
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover),
                  shape: BoxShape.rectangle,
                ),
                ),
              const SizedBox(width: 12,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.grey[800]),),
                  if(position!=null) Text(position!, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey[500]),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}