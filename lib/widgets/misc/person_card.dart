import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions.dart';
class PersonCard extends StatelessWidget {
  const PersonCard({super.key, required this.contHeight, required this.contWidth, required this.imgUrl, required this.name, required this.position, required this.deleteId, required this.vertical, required this.collName, required this.user, required this.timelineDeleteId});
  final double contHeight;
  final double contWidth;
  final String imgUrl;
  final String name;
  final String deleteId;
  final String timelineDeleteId;
  final String position;
  final bool vertical;
  final String collName;
  final String user;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: (){
          enlargeImg(context, screenSize.width*0.6, true, imgUrl, user, collName, deleteId, timelineDeleteId,
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.barlowCondensed(textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[700]),)),
              Text(position, style: GoogleFonts.barlowCondensed(textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[500]),))
            ]
          ),
        ), Container()
        );},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 2),
                  blurRadius: 5,
                ),
              ]
          ),
          child: (vertical==true)? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: contHeight,
                  width: contWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      image: DecorationImage(
                          image: NetworkImage(imgUrl), fit: BoxFit.cover)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(name, style: GoogleFonts.barlowCondensed(textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey[700]),)
                    ),
                Text(position, style: GoogleFonts.barlowCondensed(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey[500]),)
                )],
                ),
              ),
            ],
          )
              :
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: contHeight,
                      width: contWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(imgUrl), fit: BoxFit.cover)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: GoogleFonts.barlowCondensed(textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.grey[700]),)
                        ),
                        Text(position, style: GoogleFonts.barlowCondensed(textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey[500]),)
                        )],
                    ),
                  ),
                ],
              )
        ),
      ),
    );
  }
}
