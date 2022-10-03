import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:speaking_app/manager/word_manager.dart';
import 'package:speaking_app/manager/script_manager.dart';

import 'package:speaking_app/widgets/record_button.dart';
import 'dart:math';

class WordSwipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController minController = TextEditingController();
    TextEditingController maxController = TextEditingController();
    WordManager wordManager = WordManager();
    minController.text = wordManager.minLength.toString();
    maxController.text = wordManager.maxLength.toString();
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
        drawer: Draw(
          wordManager: wordManager,
        ),
        appBar: AppBar(
            actions: [
              new IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  }),
              RecordButton()
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
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
                Spacer(),
                WordSwipe(
                  wordManager: wordManager,
                ),
                Spacer(),
              ],
            )));
  }
}

class Draw extends StatefulWidget {
  const Draw({
    Key key,
    this.wordManager,
  }) : super(key: key);
  final WordManager wordManager;
  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropDown(
              wordManager: widget.wordManager,
            ),
            Divider(
              thickness: 2,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Min",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            NumberPicker.integer(
                infiniteLoop: true,
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
                initialValue: widget.wordManager.minLength,
                minValue: -1,
                maxValue: 999,
                selectedTextStyle: TextStyle(fontSize: 25, color: Colors.red),
                onChanged: (value) {
                  setState(() {
                    widget.wordManager.minLength = value;
                  });
                }),
            Divider(
              thickness: 2,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Max",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            NumberPicker.integer(
                infiniteLoop: true,
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
                initialValue: widget.wordManager.maxLength,
                selectedTextStyle: TextStyle(fontSize: 25, color: Colors.red),
                minValue: -1,
                maxValue: 999,
                onChanged: (value) {
                  setState(() {
                    widget.wordManager.maxLength = value;
                  });
                }),
            Divider(
              thickness: 2,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Syllables",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            NumberPicker.integer(
                infiniteLoop: true,
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
                selectedTextStyle: TextStyle(fontSize: 25, color: Colors.red),
                initialValue: widget.wordManager.numberOfSyl,
                zeroPad: true,
                minValue: 0,
                maxValue: 6,
                onChanged: (value) {
                  setState(() {
                    widget.wordManager.numberOfSyl = value;
                  });
                }),
            RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"))
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({
    Key key,
    this.wordManager,
  }) : super(key: key);
  final WordManager wordManager;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        style: TextStyle(fontSize: 25, color: Colors.white),
        dropdownColor: Colors.blue[900],
        value: widget.wordManager.startsWith != ""
            ? widget.wordManager.startsWith
            : "any",
        items: letterDropDownItemList(),
        onChanged: (s) {
          if (s != "any") {
            widget.wordManager.startsWith = s;
          } else {
            widget.wordManager.startsWith = "";
          }

          setState(() {});
        });
  }

  List<DropdownMenuItem> letterDropDownItemList() {
    List<DropdownMenuItem> list = [letterDropDownItem("any")];

    for (int i = 97; i < 97 + 26; i++) {
      list.add(letterDropDownItem(String.fromCharCode(i)));
    }
    return list;
  }

  DropdownMenuItem letterDropDownItem(String letter) {
    print(letter);
    return DropdownMenuItem(value: letter, child: Text(letter));
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
      if (!scriptMode)
        text = widget.wordManager.getWord();
      else
        text = ScriptManager.getWord();
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
