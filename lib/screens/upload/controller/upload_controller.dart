import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/screens/homepage/view/homepage_view.dart';

class UploadController extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  Future selectPhoto(BuildContext context) async {
    await showModalBottomSheet(
      builder: (_) {
        return Column(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () {
                Get.back();
                pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_copy_sharp),
              title: const Text("Gallery"),
              onTap: () {
                Get.to(HomePage());
                pickImage(ImageSource.gallery);
              },
            )
          ],
        );
      },
      context: context,
    );
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }
    // var file = await ImageCropper().cropImage(
    //     sourcePath: pickedFile.path,
    //     aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    // if (file == null) {
    //   return;
    // }
    // file = (await compressImage(file.path, 35)) as CroppedFile?;
    // await uploadFile(file!.path);
  }
}
