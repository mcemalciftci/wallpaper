import 'package:wallpaper/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:flutter/material.dart';
import 'package:wallpaper/screens/splash_screen.dart';
import 'firebase/locator.dart';
import 'screens/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   
  await Firebase.initializeApp();
  setupLocator() ;
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpapers',
      
      theme: ThemeData(
          fontFamily: "LobsterTwo",
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
            color: Colors.black,
          ))),
      home:  SplashScreen(),
    );
  }
}
