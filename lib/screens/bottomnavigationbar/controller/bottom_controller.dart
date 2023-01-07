import 'package:flutter/material.dart';
import 'package:new_project/screens/homepage/view/homepage_view.dart';
import 'package:new_project/screens/upload/view/upload_image.dart';

class BottomController extends ChangeNotifier {
  final List<dynamic> screens = [
    const HomePage(),
    UploadImage(),
  ];
  int currentIndex = 0;

  int currentIndexSearch() {
    return currentIndex;
  }

  currentIndexResult(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
