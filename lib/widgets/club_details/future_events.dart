import 'package:flutter/material.dart';
class FutureEvents extends StatelessWidget {
  const FutureEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(width: 2, color: Colors.black),
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Future Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
                  Stack(
                      children : [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 24, 8, 8),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.yellow[600]
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Thrilling and informative street play performed for freshers every year.", overflow: TextOverflow.ellipsis, maxLines: 5,),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent[700],
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: const Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),),
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}
