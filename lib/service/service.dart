import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

///////////////////////////////////uploading funtion
  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      log(file.toString());
      await storage.ref('test/ $fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFile() async {
    firebase_storage.ListResult result = await storage.ref('test').listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found File :$ref');
    });
    return result;
  }

  Future<String> downloadUrl(String imageName) async {
    String downloadURL = await storage.ref('test/$imageName').getDownloadURL();
    return downloadURL;
  }
}
