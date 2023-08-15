import 'package:flutter/material.dart';

import '../gradient_text.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.image, required this.name, required this.text, required this.subName}) : super(key: key);
final String image;
final String name;
final String subName;
final String text;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(tag: Key(image), child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                    child: Image.asset(image, fit: BoxFit.cover,width: double.infinity, height: 300,)),
              )),
              GradientText(
                text: name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Colors.green[400]),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 2,),
              GradientText(
                text: subName,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.green[400]),
                gradient: const LinearGradient(
                  colors: [Colors.grey, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50) )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Text(text),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
