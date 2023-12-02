import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('animations/dino.json', height: 250),
            const Text("Come back later...")
          ],
        )
      ),
    );
  }
}
