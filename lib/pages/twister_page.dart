import 'package:flutter/material.dart';
import 'package:speaking_app/manager/word_manager.dart';

import 'dart:math';

class TwisterPage extends StatelessWidget {
  const TwisterPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WordManager wordManager = WordManager();

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [new Color(0xff00c2e5), Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: WordSwipe(
        wordManager: wordManager,
      ),
    ));
  }
}

class WordSwipe extends StatefulWidget {
  const WordSwipe({
    Key key,
    this.words,
    this.wordManager,
  }) : super(key: key);

  final List<String> words;
  final WordManager wordManager;
  @override
  _WordSwipeState createState() => _WordSwipeState();
}

class _WordSwipeState extends State<WordSwipe> {
  String text = "Swipe to begain";
  bool scriptMode = false;

  void reload() {
    setState(() {
      widget.wordManager.startsWith = "a";

      
    });
  }

  @override
  Widget build(BuildContext context) {
    Random r = new Random();
    return Dismissible(
      key: Key(text + r.nextDouble().toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        reload();
      },
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
