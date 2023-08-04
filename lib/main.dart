import 'package:firebase_core/firebase_core.dart';
import 'package:music_and_art_admin_panel/Screens/drawer_dashboard_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDiTWzyTeDv8AbyrfM5jaYrJ2j043GvIrI",
      authDomain: "music-and-art-admin-pane-5564c.firebaseapp.com",
      projectId: "music-and-art-admin-pane-5564c",
      storageBucket: "music-and-art-admin-pane-5564c.appspot.com",
      messagingSenderId: "294084038891",
      appId: "1:294084038891:web:08e0e65581d04cf14b2eae",
      measurementId: "G-BB1KGXS3VQ"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // getPages: getPages,
      // unknownRoute: GetPage(name: "/not-found", page: () => FourOFourScreen()),
      // initialRoute: Routes.dashboard,
      home:
          // DemoScreen(),
          HomePage(),
    );
  }
}
