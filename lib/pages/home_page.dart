
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mnc/functions.dart';
import 'package:mnc/pages/clubs_page.dart';
import 'package:mnc/pages/events_page.dart';
import 'package:mnc/pages/stats_page.dart';
import 'package:mnc/pages/teams_page.dart';
import 'package:mnc/pages/timeline_page.dart';
import 'package:mnc/widgets/club_details/get_in_touch.dart';
import 'package:mnc/widgets/homepage_comp/homepage_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/homepage_comp/top_banner.dart';
import '../widgets/homepage_comp/upcoming_poster.dart';
import '../widgets/misc/big_button.dart';
import 'media_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isShowSignInDialog = false;
  bool isClubClicked =false;


  @override
  void initState() {
    showRemoteNotification();
    requestPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBanner(),
            const UpcomingPoster(),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TapButton(
                    onTap: (){pushPage(context, const TeamsPage());},
                    colorList: const [Colors.blue, Colors.green, Colors.lightGreen],
                    text: const ['Meet The', 'Team'],
                    textSize: const [12, 22]
                ),
                TapButton(
                    onTap: (){pushPage(context, const TimeLinePage());},
                    colorList: [Colors.green.shade500, Colors.blue.shade300],
                    text: const ["Activity", "Timeline"],
                    textSize: const [12, 20]
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TapButton(
                    onTap: (){pushPage(context, const MediaPage());},
                    colorList: const [Colors.blue, Colors.green, Colors.orange],
                    text: const ["Media", "Collection"],
                    textSize: const [20, 12]
                ),
                TapButton(
                    onTap: (){pushPage(context, const StatsPage());},
                    colorList: const [Colors.blue, Colors.green, Colors.orange],
                    text: const ["Stats", "for nerds"],
                    textSize: const [20, 12]
                ),
              ],
            ),
            const Gap(50),
            HomePageCard(
              onTap: (){pushPage(context, const ClubsPage());},
              children: [
                  RotatedBox(
                    quarterTurns: -1,
                    child: Text("CLUBS", style: GoogleFonts.bungee(textStyle: TextStyle(fontSize: 30, color: Colors.orange.shade700),)),
                  ),
                  Lottie.asset('animations/club.json', height: 110),
                  Icon(Icons.arrow_forward_ios_rounded, size: 40, color: Colors.orange.shade800),
                ],
            ),
            HomePageCard(
              onTap: (){pushPage(context, const EventsPage());},
                children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 40, color: Colors.orange.shade800),
                    Lottie.asset('animations/events.json', height: 130),
                    RotatedBox(
                        quarterTurns: -1,
                        child: Text("Events", style: GoogleFonts.bungee(textStyle: TextStyle(fontSize: 30, color: Colors.orange.shade700),))                ),
                  ],
            ),
            Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: (){
                      launchUrl(
                          Uri.parse('https://www.facebook.com/mnciitk/'),
                          mode: LaunchMode.externalApplication
                      );
                    },
                    icon: Lottie.asset('animations/facebook.json', width: 80)
                ),
                IconButton(
                    onPressed: () {
                      launchUrl(
                          Uri.parse('https://www.instagram.com/mnciitk/'),
                          mode: LaunchMode.externalApplication
                      );
                    },
                    icon: Lottie.asset('animations/instagram.json', width: 80)
                ),
              ],
            ),
            Gap(10),
            SizedBox(
              width: screenSize.width,
              child: Column(
                children: [
                  Text('Copyright © 2023',style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.grey.shade400), ),
                  Text('All Rights Reserved by MnC Council.',style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.grey.shade400), ),

                ],
              ),
            ),

            const SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}


class TapButton extends StatelessWidget {
  const TapButton({super.key, required this.onTap, required this.colorList, required this.text, required this.textSize});
  final Function() onTap;
  final List<Color> colorList;
  final List<String> text;
  final List<double> textSize;

  @override
  Widget build(BuildContext context) {
    return BigButton(
      height: 70,
      align: Alignment.centerLeft,
      onTap: onTap,
      colorList: colorList,
      children: [
        Text(text[0],style: TextStyle(fontSize: textSize[0], fontWeight: FontWeight.w800, color: Colors.white), ),
        Text(text[1],style: TextStyle(fontSize: textSize[1], fontWeight: FontWeight.w800, color: Colors.white), ),
      ],
    );
  }
}

