import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key, required this.onTap, required this.height, required this.width, required this.label, this.topLeft, this.topRight, this.bottomLeft, this.bottomRight, this.fontSize, required this.color, required this.textColor});

  // final bool isOn;
  final Function() onTap;
  final double height;
  final double width;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;
  final String label;
  final double? fontSize;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular((topLeft!=null)? topLeft!: 0), topRight: Radius.circular((topRight!=null)? topRight!: 0), bottomLeft: Radius.circular((bottomLeft!=null)? bottomLeft!: 0), bottomRight: Radius.circular((bottomRight!=null)? bottomRight!: 0)),
        color: color,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w900, fontSize: (fontSize!=null)? fontSize!:16),),
      ),
    );
  }
}