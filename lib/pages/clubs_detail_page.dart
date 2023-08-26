import 'package:flutter/material.dart';
import 'package:mnc/widgets/club_details/cordi_name.dart';
import 'package:mnc/widgets/club_details/future_events.dart';
import 'package:mnc/widgets/club_details/get_in_touch.dart';
import 'package:mnc/widgets/club_details/performances.dart';

import '../gradient_text.dart';
import '../widgets/card.dart';
class ClubDetail extends StatefulWidget {
  ClubDetail({Key? key, required this.image, required this.name, required this.subName, required this.text, required this.clubName}) : super(key: key);
  final String image;
  final String name;
  final String subName;
  final String clubName;
  final String text;

  @override
  State<ClubDetail> createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                    tag: Key(widget.image),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(widget.image, fit: BoxFit.fill,width: double.infinity, height: 200,)
                    )
                ),
                const SizedBox(height: 20,),
                GradientText(
                  text: widget.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.green[400]),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.green, Colors.lightGreen, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                GradientText(
                  text: widget.subName,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.green[400]),
                  gradient: const LinearGradient(
                    colors: [Colors.grey, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                const SizedBox(height: 80,),
                FutureEvents(clubName:  widget.clubName,),
                const SizedBox(height: 50,),
                const RecPerformance(),
                const SizedBox(height: 50,),
                const Text(
                  'Meet The Team',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                CordiName(clubName: widget.clubName),
                const SizedBox(height: 30,),
                const InTouch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
