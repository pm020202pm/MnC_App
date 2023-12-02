import 'package:flutter/material.dart';
import 'dart:io';

class PhotoUpload extends StatelessWidget {
  const PhotoUpload({super.key, this.compressedImageFile, required this.onTap, required this.imgHeight, required this.imgWidth, required this.radius});

  final File? compressedImageFile;
  final Function() onTap;
  final double imgHeight;
  final double imgWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: (compressedImageFile != null)
          ? Container(
        height: imgHeight,
        width: imgWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
              image:FileImage(compressedImageFile!),
              fit: BoxFit.cover),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(radius),
        ),
      )
          : Container(
          height: imgHeight, width: imgWidth,
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(radius),
          ),
          child: IconButton(
              color: Colors.grey[750],
              onPressed: onTap,
              icon: const Icon(Icons.add_a_photo_outlined, size: 40,)
          )),
    );
  }
}