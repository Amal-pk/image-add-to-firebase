import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomePageController extends ChangeNotifier {
  
  String imageUrl = "";
 FirebaseAuth auth = FirebaseAuth.instance;
  void imageChanged(String imageUrl) {
    imageUrl = imageUrl;
    notifyListeners();
  }

 

 

  Future<File?> compressImage(String path, int quality) async {
    final newpath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newpath,
        quality: quality);
    return result;
  }

  Future uploadFile(String path) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('image')
        .child(DateTime.now().toIso8601String() + p.basename(path));
    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();
    imageUrl = fileUrl;
    notifyListeners();
    imageChanged(fileUrl);
  }
   void logout() async {
    await auth.signOut();
  }
}
