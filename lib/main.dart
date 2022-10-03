import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/reader_page.dart';
import 'pages/random_word_swiper.dart';
import 'pages/twister_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: "HOME",
        routes: {
          "HOME": (context) => HomePage(),
          "READER": (context) => ReaderPage(),
          "SWIPER": (context) => WordSwipePage(),
          "TWISTER": (context) => TwisterPage(),
        },
        title: 'Speaking App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }
}
