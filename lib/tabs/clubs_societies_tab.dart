import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/big_card.dart';
class Clubs extends StatefulWidget {
  Clubs({Key? key}) : super(key: key);

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  bool isClub = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        children: [
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  color: (isClub)? Colors.blue[100] : Colors.grey[200],
                ),

                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isClub =true;
                    });
                  },
                  child: Text("CLUB", style: TextStyle(color: (isClub)? Colors.blue: Colors.grey[500], fontWeight: FontWeight.w900, fontSize: 18),),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                  color: (!isClub)? Colors.blue[100] : Colors.grey[200],
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isClub = false;
                    });
                  },
                  child: Text("SOCIETIES", style: TextStyle(color: (!isClub)? Colors.blue: Colors.grey, fontWeight: FontWeight.w900, fontSize: 18),),
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          (isClub)
              ? Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BigCard(imageUrl: 'assets/book.jpg', name: 'BOOK CLUB', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: galaxyText, subName: subGalaxy, radius: 16,),
                      BigCard(imageUrl: 'assets/kos.png', name: 'DANCE CLUB', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: freshersText, subName: subFreshers, radius: 16,),
                      BigCard(imageUrl: 'assets/dna.png', name: 'DNA CLUB',imageHeight: 140, imageWidth: 300, cardHeight: 100, text: impressionText, subName: subImpression, radius: 16,color: Colors.pink[200],),
                      BigCard(imageUrl: 'assets/fursatmandali.jpg', name: 'DRAMATICS',  imageHeight: 140, imageWidth: 300, cardHeight: 100, text: montageText, subName: subMontage, radius: 16,),
                      BigCard(imageUrl: 'assets/fac.png', name: 'FINE ARTS CLUB', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.black,),
                      BigCard(imageUrl: 'assets/film.png', name: 'FILM CLUB', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.yellow[800],),
                      BigCard(imageUrl: 'assets/mclub.png', name: 'MUSIC CLUB', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.blue[200],),
                      BigCard(imageUrl: 'assets/photo.png', name: 'PHOTOGRAPHY', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.green[300],),
                      BigCard(imageUrl: 'assets/qc.png', name: 'QUIZ CLUB', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.blue[400],),
                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              )
          : Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BigCard(imageUrl: 'assets/anime.png', name: 'ANIME', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: galaxyText, subName: subGalaxy, radius: 16, color: Colors.yellow[800],),
                  BigCard(imageUrl: 'assets/debsoc1.png', name: 'DEBATING SOCIETY', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: freshersText, subName: subFreshers, radius: 16,),
                  BigCard(imageUrl: 'assets/ELS.jpeg', name: 'ELS',imageHeight: 140, imageWidth: 300, cardHeight: 100, text: impressionText, subName: subImpression, radius: 16,color: Colors.white,),
                  BigCard(imageUrl: 'assets/hss.png', name: 'HSS',  imageHeight: 140, imageWidth: 300, cardHeight: 100, text: montageText, subName: subMontage, radius: 16, color: Colors.purple[300],),
                  BigCard(imageUrl: 'assets/hh.png', name: 'HUMOUR HOUSE', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.black,),
                  BigCard(imageUrl: 'assets/sfs.png', name: 'SFS', imageHeight: 140, imageWidth: 300, cardHeight: 100, text: cultText, subName: subCult, radius: 16, color: Colors.yellow[800],),
                  SizedBox(height: 100,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
