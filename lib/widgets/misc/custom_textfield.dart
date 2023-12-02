import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  const MyTextField({Key? key, required this.controller, this.labelText, this.hintText, required this.boxHeight, this.maxLines}) : super(key: key);
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final double boxHeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: boxHeight,
        child: TextField(
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 14,),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 13),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue, width: 0,),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlue, width: 1,),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            filled: true,
          ),
        ),
      ),
    );
  }
}
