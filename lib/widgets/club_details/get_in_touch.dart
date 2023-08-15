import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class InTouch extends StatelessWidget {
  const InTouch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[200]
      ),
      child: Column(
        children: [
          const Text('Get In Touch', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: (){},
                icon: SvgPicture.asset('assets/facebook.svg', width: 40,),
              ),
              IconButton(
                onPressed: (){},
                icon: SvgPicture.asset('assets/facebook.svg', width: 40,),
              ),
              IconButton(
                onPressed: (){},
                icon: SvgPicture.asset('assets/facebook.svg', width: 40,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
