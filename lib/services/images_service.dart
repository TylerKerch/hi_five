// import 'dart:developer';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
//
// class ImagesService {
//   static Future<File?> chooseImage(BuildContext context) async {
//     ImageSource? source = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             title: const Text('Select Image From:'),
//             children: [
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, ImageSource.camera);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(Icons.camera_alt_outlined, size: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.07,),
//                     SizedBox(width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.02,),
//                     const Text('Camera', style: TextStyle(fontSize: 16.0),),
//                   ],
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, ImageSource.gallery);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(Icons.collections_outlined, size: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.07,),
//                     SizedBox(width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.02,),
//                     const Text('Gallery', style: TextStyle(fontSize: 16.0),),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//
//     if (source != null) {
//       XFile? file = await ImagePicker().pickImage(source: source);
//       if (file != null) {
//         return File(file.path);
//       }
//     }
//   }
//
//   static Future<List<File>?> chooseMultiImage(BuildContext context) async {
//     ImageSource? source = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             title: const Text('Select Image From:'),
//             children: [
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, ImageSource.camera);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(Icons.camera_alt_outlined, size: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.07,),
//                     SizedBox(width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.02,),
//                     const Text('Camera', style: TextStyle(fontSize: 16.0),),
//                   ],
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, ImageSource.gallery);
//                 },
//                 child: Row(
//                   children: [
//                     Icon(Icons.collections_outlined, size: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.07,),
//                     SizedBox(width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.02,),
//                     const Text('Gallery', style: TextStyle(fontSize: 16.0),),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//
//     if (source != null) {
//       if (source == ImageSource.camera) {
//         XFile? file = await ImagePicker().pickImage(source: source);
//         if (file != null) {
//           return [File(file.path)];
//         }
//       } else {
//         List<XFile>? files = await ImagePicker().pickMultiImage();
//         if (files != null) {
//           return List<File>.from(files.map((XFile file) => File(file.path)));
//         }
//       }
//     }
//   }
//
//   static Future<String> uploadImage(String name, File file) async {
//     Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(name);
//     UploadTask uploadTask = firebaseStorageRef.putFile(file);
//     TaskSnapshot taskSnapshot = await uploadTask;
//     return await taskSnapshot.ref.getDownloadURL();
//   }
//
//   static Future<List<String>> uploadImagesToSpaces(List<File> files) async {
//     try {
//       Dio dio = Dio();
//       FormData data = FormData();
//       data.files.addAll(files.map((File file) =>
//           MapEntry('files', MultipartFile.fromFileSync(
//               file.path, filename: basename(file.path)))));
//       var response = await dio.post(
//           'https://pictag-api.herokuapp.com/api/upload', data: data);
//       if (response.statusCode == 200) {
//         return files.map((File file) => 'https://pictag.sfo3.cdn.digitaloceanspaces.com/messagePics/${basename(file.path)}').toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       log(e.toString());
//       return [];
//     }
//   }
// }