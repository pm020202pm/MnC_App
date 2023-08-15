import 'package:flutter/material.dart';

import '../widgets/card.dart';
class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            Text('About Us', style: TextStyle(fontSize: 42, fontWeight: FontWeight.w800, color: Colors.grey[500])),
            const SizedBox(height: 22,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[100],
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text('WHAT ARE WE?', style: TextStyle(fontSize: 26)),
                    Text('The Media and Cultural Council at IITK is a hub for all activities about media and culture. Sounds obvious, right? Obvious as it may be, the implications of that have enriched the campus experience for innumerable students. Led by a dedicated team along with the respective clubs, the council organises a plethora of events throughout each year. From full-fledged workshops to hour-long impromptu sessions, we do it all.', textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22,),
            const Text('MEET THE TEAM', style: TextStyle(fontSize: 26)),
            IntroCard(imageUrl: 'https://students.iitk.ac.in/mnc/img/mncTeamAvtar/ghanshyam.jpg', name: 'GHANSHYAM WAINDESHKAR', position: 'General Secretary, Media & Culture', imageHeight: 40, imageWidth: 40, cardHeight: 50,),
            IntroCard(imageUrl: 'https://students.iitk.ac.in/mnc/img/mncTeamAvtar/bidhanarya.jpg', name: 'BIDHAN ARYA', position: 'Associate Head, Non Performing Arts', imageHeight: 40, imageWidth: 40, cardHeight: 50,),
            IntroCard(imageUrl: 'https://students.iitk.ac.in/mnc/img/mncTeamAvtar/yatharth.jpg', name: 'YATHARTH GUPTA', position: 'Associate Head, Performing Arts', imageHeight: 40, imageWidth: 40, cardHeight: 50,),
            IntroCard(imageUrl: 'https://students.iitk.ac.in/mnc/img/mncTeamAvtar/shalvin.jpeg', name: 'SHALVIN SAKSENA', position: 'Associate Head, Films And Media', imageHeight: 40, imageWidth: 40, cardHeight: 50,),
            const SizedBox(height: 22,),
            const Text('MEET THE SECRETARIES', style: TextStyle(fontSize: 26)),
            Container(
                child: Column(
                  children: [
                    IntroCard(imageUrl: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', name: 'Aditya Sharma', imageHeight: 28, imageWidth: 28, cardHeight: 38,),
                    IntroCard(imageUrl: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', name: 'Akash kumar', imageHeight: 28, imageWidth: 28, cardHeight: 38,),
                  ],
                )
            ),
            const SizedBox(height: 22,),
            const Text('GET IN TOUCH', style: TextStyle(fontSize: 26)),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(Icons.facebook, color: Colors.blue,),
                    Text('Facebook')
                  ],
                ),
                SizedBox(width: 100,),
                Column(
                  children: [
                    Icon(Icons.facebook, color: Colors.blue,),
                    Text('Instagram')
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
