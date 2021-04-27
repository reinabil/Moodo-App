import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moodo/view/mainPage.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(ProviderScope(child: Moodo()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));
}

class Moodo extends StatefulWidget {
  @override
  _MoodoState createState() => _MoodoState();
}

class _MoodoState extends State<Moodo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moodo",
      theme: ThemeData.dark(),
      // brightness: Brightness.dark,
      // backgroundColor: const Color(0xFF212121),
      // accentIconTheme: IconThemeData(color: Colors.black),
      // dividerColor: Colors.black12,
      // // Define the default brightness and colors.
      // primaryColor: Colors.teal,
      // accentColor: Colors.tealAccent),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: SplashScreenView(
        home: MainPage(),
        duration: 2000,
        imageSize: 100,
        imageSrc: "images/logo.png",
        text: "Du'a for your daily mood",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(fontSize: 14, fontFamily: "Poppins"),
        backgroundColor: Colors.white,
      ),
    );
  }
}
