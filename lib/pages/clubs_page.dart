import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});
  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  int currIndex =0;
  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: widgets,
              carouselController: carouselController,
              options: CarouselOptions(
                  height: 450,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enlargeCenterPage: true,
                  viewportFraction: 0.68,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currIndex = index;
                      // print(currIndex);
                    });
                  }),
            ),
            SizedBox(
              height: 40,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Circle(currIndex: currIndex, index: 0),
                  Circle(currIndex: currIndex, index: 1),
                  Circle(currIndex: currIndex, index: 2),
                  Circle(currIndex: currIndex, index: 3),
                  Circle(currIndex: currIndex, index: 4),
                  Circle(currIndex: currIndex, index: 5),
                  Circle(currIndex: currIndex, index: 6),
                  Circle(currIndex: currIndex, index: 7),
                  Circle(currIndex: currIndex, index: 8),
                  Circle(currIndex: currIndex, index: 9),
                  Circle(currIndex: currIndex, index: 10),
                  Circle(currIndex: currIndex, index: 11),
                  Circle(currIndex: currIndex, index: 12),
                  Circle(currIndex: currIndex, index: 13),
                  Circle(currIndex: currIndex, index: 14),
                ],
              ),
            )
          ],
        )

    );
  }
}


class Circle extends StatelessWidget {
  Circle({super.key, required this.currIndex, required this.index});
  final int currIndex;
  final int index;
  double bigSize=10;
  double smallSize=6;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (currIndex==index)?bigSize:smallSize,
      width: (currIndex==index)?bigSize:smallSize,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)
      ),
    );
  }
}

