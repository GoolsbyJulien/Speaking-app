import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [new Color(0xff00c2e5), Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "SWIPER");
                },
                child: Text(
                  "Word Swiper",
                  style: TextStyle(fontSize: 30),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "READER");
                },
                child: Text(
                  "Reader",
                  style: TextStyle(fontSize: 30),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, "TWISTER");
                },
                child: Text(
                  "TWISTER",
                  style: TextStyle(fontSize: 30),
                )),
          ),
        ],
      ),
    ));
  }
}
