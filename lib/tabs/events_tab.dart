import 'package:flutter/material.dart';
import 'package:mnc/constants.dart';

import '../widgets/big_card.dart';
class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
 int num = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 55,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                  color: (num==1)? Colors.blue[100] : Colors.grey[200],
                ),

                child: TextButton(
                  onPressed: () {
                    setState(() {
                      num= 1;
                    });
                  },
                  child: Text("EVENTS", style: TextStyle(color: (num==1)? Colors.blue: Colors.grey[500], fontWeight: FontWeight.w900, fontSize: 18),),
                ),
              ),
              Container(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                height: 55,
                width: 120,
                decoration: BoxDecoration(
                  color: (num==2)? Colors.blue[100] : Colors.grey[200],
                ),

                child: TextButton(
                  onPressed: () {
                    setState(() {
                      num =2;
                    });
                  },
                  child: Column(
                    children: [
                      Text("UPCOMING", style: TextStyle(color: (num==2)? Colors.blue: Colors.grey[500], fontWeight: FontWeight.w900, fontSize: 16,)),
                      Text("EVENTS", style: TextStyle(color: (num==2)? Colors.blue: Colors.grey[500], fontWeight: FontWeight.w800, fontSize: 10),),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 55,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                  color: (num==3)? Colors.blue[100] : Colors.grey[200],
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      num = 3;
                    });
                  },
                  child: Column(
                    children: [
                      Text("PAST", style: TextStyle(color: (num==3)? Colors.blue: Colors.grey[500], fontWeight: FontWeight.w900, fontSize: 16,)),
                      Text("EVENTS", style: TextStyle(color: (num==3)? Colors.blue: Colors.grey[500], fontWeight: FontWeight.w800, fontSize: 10),),
                    ],
                  ),
                ),
              )
            ],
          ),
          if(num==1) Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              children: [
                BigCard(imageUrl: 'assets/galaxy.jpg', name: 'GALAXY', imageHeight: 150, imageWidth: 140, cardHeight: 170, text: galaxyText, subName: subGalaxy, radius: 16,),
                BigCard(imageUrl: 'assets/freshers.jpg', name: 'FRESHERS', imageHeight: 150, imageWidth: 140, cardHeight: 170, text: freshersText, subName: subFreshers, radius: 16,),
                BigCard(imageUrl: 'assets/impression.jpg', name: 'IMPRESSIONS',imageHeight: 150, imageWidth: 140, cardHeight: 170, text: impressionText, subName: subImpression, radius: 16,),
                BigCard(imageUrl: 'assets/montage.jpg', name: 'MONTAGE FILM FESTIVAL',  imageHeight: 150, imageWidth: 140, cardHeight: 170, text: montageText, subName: subMontage, radius: 16,),
                BigCard(imageUrl: 'assets/cultcover.jpg', name: 'INTER IIT CULTURAL MEET', imageHeight: 150, imageWidth: 140, cardHeight: 170, text: cultText, subName: subCult, radius: 16,),
              ],
            ),
          ),
          if(num==2) Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              children: [
                BigCard(imageUrl: 'assets/galaxy.jpg', name: 'GALAXY', imageHeight: 150, imageWidth: 140, cardHeight: 170, text: galaxyText, subName: subGalaxy, radius: 16,),
                BigCard(imageUrl: 'assets/freshers.jpg', name: 'FRESHERS', imageHeight: 150, imageWidth: 140, cardHeight: 170, text: freshersText, subName: subFreshers, radius: 16,),
                BigCard(imageUrl: 'assets/impression.jpg', name: 'IMPRESSIONS',imageHeight: 150, imageWidth: 140, cardHeight: 170, text: impressionText, subName: subImpression, radius: 16,),
                BigCard(imageUrl: 'assets/montage.jpg', name: 'MONTAGE FILM FESTIVAL',  imageHeight: 150, imageWidth: 140, cardHeight: 170, text: montageText, subName: subMontage, radius: 16,),
                BigCard(imageUrl: 'assets/cultcover.jpg', name: 'INTER IIT CULTURAL MEET', imageHeight: 150, imageWidth: 140, cardHeight: 170, text: cultText, subName: subCult, radius: 16,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
