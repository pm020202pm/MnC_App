import 'package:flutter/material.dart';

class TimeLineCard extends StatelessWidget {
  const TimeLineCard({super.key, required this.time, required this.date, required this.content, required this.childImg});
  final String time;
  final String date;
  final String content;
  final Widget childImg;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: 120,
      color: Colors.green.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenSize.width*0.65+20+35),
                child: Container(
                  height: 120,
                  width: 3,
                  color: Colors.grey,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 38,
                      alignment: Alignment.center,
                      width:70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Column(
                          children: [
                            Text(time, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900,color: Colors.grey.shade700),),
                            Text(date, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900,color: Colors.grey.shade500),),
                          ],
                        ),
                      )),
                  Container(
                    width: 20,
                    height: 1.5,
                    color: Colors.grey.shade500,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 29, bottom: 29),
                    child: Container(
                      width: screenSize.width*0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow[600]),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(content, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,color: Colors.grey.shade800), overflow: TextOverflow.ellipsis, maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                        height: 35,
                        width: 35,
                        child: childImg)
                ),
              )
            ],
          ),


        ],
      ),
    );
  }
}