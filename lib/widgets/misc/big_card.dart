import 'package:flutter/material.dart';
import 'package:mnc/pages/clubs_detail_page.dart';
class BigCard extends StatelessWidget {
  BigCard({Key? key, required this.imageUrl, required this.name, this.position, required this.clubName}) : super(key: key);
  final String imageUrl;
  final String name;
  final String clubName;
  late String? position;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ClubDetail(image: imageUrl, name: name, clubName: clubName,)));},
          child: Hero(tag: Key(imageUrl),child: Image.asset(imageUrl, fit: BoxFit.fill, height: 300,)),
        ),
      ),
    );
  }
}
