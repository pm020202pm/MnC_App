import 'package:flutter/material.dart';
class BigButton extends StatelessWidget {
  BigButton({super.key, required this.colorList, this.onTap, required this.children, this.align, this.height, this.width});
  final List<Color> colorList;
  final Function()? onTap;
  final List<Widget> children;
  final AlignmentGeometry? align;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: (align!=null)? align: Alignment.center,
        height: (height!=null)? height:80 ,
        width: (width!=null)? width: 140 ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: colorList,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}