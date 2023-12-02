import 'package:flutter/material.dart';
class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key, required this.height, required this.width, required this.iconSize, required this.radius, this.backgroundColor, required this.icon, this.onTap, this.iconColor});
  final double height;
  final double width;
  final double iconSize;
  final double radius;
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: (backgroundColor!=null)? backgroundColor : Colors.greenAccent[700],
          borderRadius: BorderRadius.circular(height)),
      child: IconButton(iconSize: iconSize, onPressed: onTap, icon: Icon(icon), color: (iconColor!=null)? iconColor : Colors.white,),
    );
  }
}