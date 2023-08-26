import 'package:flutter/material.dart';
import 'package:mnc/pages/clubs_detail_page.dart';

import '../pages/details_page.dart';
class BigCard extends StatelessWidget {
  BigCard({Key? key, required this.imageUrl, required this.name, required this.imageHeight, required this.imageWidth, required this.cardHeight, this.position, required this.text, required this.subName, this.color, required this.radius, required this.clubName}) : super(key: key);
  final String imageUrl;
  final String name;
  final String subName;
  final String clubName;
  final String text;
  final double imageHeight;
  final double imageWidth;
  final double cardHeight;
  final double radius;
  late String? position;
  late Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.none,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ClubDetail(image: imageUrl, name: name, text: text, subName: subName, clubName: clubName,)));},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(22),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(radius),
                    ),

                    height: imageHeight,
                    width: imageWidth,
                    child: Hero(tag: Key(imageUrl),child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                        child: Image.asset(imageUrl, fit: BoxFit.cover,))),
                  ),
                  const SizedBox(height: 8,),
                  Text(name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.grey[700]),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
