import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:new_project/screens/bottomnavigationbar/view/bottomnavigationbar.dart';
import 'package:new_project/screens/homepage/view/homepage_view.dart';
import 'package:provider/provider.dart';

import '../controller/auth_login_provider.dart';
import 'login_page.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<FirebaseAuthLogInProvider>(context);
    return StreamBuilder<User?>(
      stream: data.straem(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const ScreenLogin();
        }
        //  else {
        //   // return const ScreenDashBoard();
        // }
        return const BottomNavigationBarPage();
        //  ScreenProfile(userId: '',);
      },
    );
  }
}
