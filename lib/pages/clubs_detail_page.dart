
import 'package:flutter/material.dart';
import 'package:mnc/widgets/club_details/cordi_list.dart';
import 'package:mnc/widgets/club_details/future_events.dart';
import 'package:mnc/widgets/club_details/get_in_touch.dart';
import 'package:mnc/widgets/club_details/media_list.dart';
import '../widgets/misc/big_button.dart';
import '../widgets/misc/gradient_text.dart';
class ClubDetail extends StatefulWidget {
  ClubDetail({Key? key, required this.image, required this.name, required this.clubName}) : super(key: key);
  final String image;
  final String name;
  final String clubName;

  @override
  State<ClubDetail> createState() => _ClubDetailState();
}

class _ClubDetailState extends State<ClubDetail> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: Key(widget.image),
              child: Image.asset('assets/fullcover/${widget.clubName}.png', fit: BoxFit.fitWidth,width: double.infinity, height: 340,)
            ),
            const SizedBox(height: 30,),
            GradientText(
              text: widget.name,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.green[400]),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.green, Colors.lightGreen, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigButton(
                  colorList: const [Colors.blue, Colors.green, Colors.lightGreen],
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FutureEvents(clubName: widget.clubName,)));},
                  children: const [Text('Events',style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w800, color: Colors.white), ),]
                ),
                BigButton(
                  colorList: const [Colors.blue, Colors.green, Colors.orange],
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MediaList(clubName: widget.clubName,)));},
                 children: const [Text('Media',style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w800, color: Colors.white), ),]
                ),
              ],
            ),
            const SizedBox(height: 40,),
            ClubCordiList(clubName: widget.clubName, name: widget.name,),
            const SizedBox(height: 40,),
            InTouch(clubName: widget.clubName,),
          ],
        ),
      ),
    );
  }
}


