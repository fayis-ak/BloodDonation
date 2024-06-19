import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelperG {
  static Future<XFile?> pickImageFromGallery() async {
    final picker = ImagePicker();
     return picker.pickImage(source: ImageSource.gallery);

  }
}
class ImagePickerHelperC {
  static Future<XFile?> pickImageFromCamera() async {
    final picker = ImagePicker();
     return picker.pickImage(source: ImageSource.camera);

  }
}
// class ImagePickerHelperC {
//   static Future<XFile?> pickImageFromCamera() async {
//     final picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//     if (image != null) {
//       final path = File(image.path);
//       return XFile(path.path);
//     }
//
//     return null; // Return null if the user cancels the image picking
//   }
// }


// class ImagePickerHelperCamera{
//   static Future<Image?>pickImageFromGallery()async{
//     final picker=ImagePicker();
//     final pickedfilecamera=await picker.pickImage(source: ImageSource.camera);
//     if(pickedfilecamera==null){
//       return null;
//     }
//     return Image.file(File(pickedfilecamera.path));
//   }
// }