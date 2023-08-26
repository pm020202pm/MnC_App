import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../constants.dart';
import '../widgets/big_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final CarouselController carouselController = CarouselController();
  int currIndex = 0;
  List<Widget> widgets = [
    BigCard(
      imageUrl: 'assets/book.jpg',
      name: 'BOOK CLUB',
      imageHeight: 140,
      imageWidth: 300,
      cardHeight: 100,
      text: galaxyText,
      subName: subGalaxy,
      radius: 16, clubName: '',
    ),
    BigCard(
      imageUrl: 'assets/kos.png',
      name: 'DANCE CLUB',
      imageHeight: 140,
      imageWidth: 300,
      cardHeight: 100,
      text: freshersText,
      subName: subFreshers,
      radius: 16, clubName: '',
    ),
    BigCard(
      imageUrl: 'assets/dna.png',
      name: 'DNA CLUB',
      imageHeight: 140,
      imageWidth: 300,
      cardHeight: 100,
      text: impressionText,
      subName: subImpression,
      radius: 16,
      color: Colors.pink[200], clubName: '',
    ),
    BigCard(
      imageUrl: 'assets/fursatmandali.jpg',
      name: 'DRAMATICS',
      imageHeight: 140,
      imageWidth: 300,
      cardHeight: 100,
      text: montageText,
      subName: subMontage,
      radius: 16, clubName: '',
    ),
  ];

  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        InkWell(
          onTap: () {},
          child: CarouselSlider(
            items: widgets,
            carouselController: carouselController,
            options: CarouselOptions(
                scrollPhysics: BouncingScrollPhysics(),
                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currIndex = index;
                    print(currIndex);
                  });
                }),
          ),
        )
      ],
    );
  }
}
