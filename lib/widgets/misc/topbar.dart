import 'package:flutter/material.dart';
import 'package:mnc/widgets/misc/my_icon_button.dart';
import '../../constants.dart';
class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.heading, required this.onTap, this.fntSize, this.fntColor, required this.user});
  final String heading;
  final Function() onTap;
  final double? fntSize;
  final Color? fntColor;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading, style: TextStyle(color: fntColor, fontWeight: FontWeight.w900, fontSize: (fntSize==null)? 10: fntSize),),
          if(userName==user) MyIconButton(height: 34, width: 50, iconSize: 20, radius: 20, icon: Icons.add, iconColor: Colors.black, onTap: onTap,),
        ],
      ),
    );
  }
}