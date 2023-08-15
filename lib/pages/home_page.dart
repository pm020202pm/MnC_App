import 'package:flutter/material.dart';
import 'package:mnc/tabs/events_tab.dart';
import 'package:mnc/tabs/home_tab.dart';
import '../tabs/about_us_tab.dart';
import '../tabs/clubs_societies_tab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int num = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if(num==1) const HomeTab(),
          if(num==2) Clubs(),
          if(num==3) const Events(),
          if(num==4) const AboutUs(),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 3,
                    blurRadius: 12,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              height: 60,
              width: 424,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 85,
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
                        child: Column(
                          children: [
                            Icon((num==1)? Icons.home :Icons.home_outlined),
                            const Text('Home')
                          ],
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 85,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      color: (num==2)? Colors.blue[100] : Colors.grey[200],
                    ),

                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          num= 2;
                        });
                      },
                      child: Column(
                        children: [
                          Icon((num==2)? Icons.people_alt_rounded :Icons.people_alt_outlined),
                          Text('Clubs')
                        ],
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    height: 60,
                    width: 85,
                    decoration: BoxDecoration(
                      color: (num==3)? Colors.blue[100] : Colors.grey[200],
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          num =3;
                        });
                      },
                      child: const Column(
                        children: [
                          Icon(Icons.event_note_rounded),
                          Text('Events')
                        ],
                      )
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
                      color: (num==4)? Colors.blue[100] : Colors.grey[200],
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          num = 4;
                        });
                      },
                      child: Column(
                        children: [
                          Icon((num==4)? Icons.supervised_user_circle : Icons.supervised_user_circle_outlined ),
                          const Text('About')
                        ],
                      )
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
