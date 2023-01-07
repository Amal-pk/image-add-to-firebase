import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/screens/homepage/controller/home_controller.dart';
import 'package:new_project/screens/login/controller/auth_login_provider.dart';
import 'package:new_project/screens/login/controller/auth_registration_provider.dart';
import 'package:new_project/screens/login/view/screen_splash.dart';
import 'package:provider/provider.dart';

import 'screens/bottomnavigationbar/controller/bottom_controller.dart';
import 'screens/upload/controller/upload_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomePageController(),
          ),
          ChangeNotifierProvider(
            create: (context) => BottomController(),
          ),
          ChangeNotifierProvider(
            create: (context) => FirebaseAuthSignUPProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UploadController(),
          ),
          ChangeNotifierProvider(
            create: (context) => FirebaseAuthLogInProvider(),
          ),
          StreamProvider(
            create: (context) =>
                context.watch<FirebaseAuthLogInProvider>().straem(),
            initialData: null,
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreenSplash(),
        ));
  }
}
