import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:new_project/screens/upload/controller/upload_controller.dart';
import 'package:new_project/service/service.dart';
import 'package:provider/provider.dart';


class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final controller = Provider.of<UploadController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Upload Image"),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: (() async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  allowedExtensions: ["png", "jpg"],
                  type: FileType.custom,
                );

                if (results == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("No Fie Selected"),
                    ),
                  );
                  return null;
                }
                final paths = results.files.single.path!;
                final fileName = results.files.single.name;

                storage.uploadFile(paths, fileName).then(
                      (value) => print("Done"),
                    );
                //   print(paths);
                //   print(fileName);
              }),
              child: const Text("Upload"),
            ),
          ),
          
        ],
      ),
    );
  }
}
