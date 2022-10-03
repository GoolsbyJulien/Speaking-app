import 'package:flutter/material.dart';

import 'package:speaking_app/manager/script_manager.dart';
import 'package:speaking_app/widgets/record_button.dart';
import 'package:speaking_app/widgets/timer.dart';

class ReadPageManager extends ChangeNotifier {
  String text = ScriptManager.currentScript.text;

  void reset(t) {
    print("called");
    text = t;
    notifyListeners();
  }
}

class ReaderPage extends StatelessWidget {
  final ReadPageManager readPageManager = ReadPageManager();
  final TextEditingController inputController = TextEditingController();
  final Stopwatch stopwatch = new Stopwatch();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            actions: [
                            TimerS(stopwatch),

              new IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  }),
              RecordButton(stopwatch),
            ],
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        drawer: Drawer(
          child: Container(
            color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 80),
                  child: Container(
                    color: Colors.white,
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (text) {
                        Navigator.pop(context);
                        readPageManager.reset(text);
                      },
                      controller: inputController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 70))),
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ),
                RaisedButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);

                      readPageManager.reset(inputController.text);
                    }),
                RaisedButton(
                    child: Text("Load"),
                    onPressed: () {
                      inputController.text = ScriptManager.currentScript.text;
                    })
              ],
            ),
          ),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [new Color(0xff00c2e5), Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: ReaderList(
              text: ScriptManager.currentScript.text,
              readPageManager: readPageManager,
            )));
  }
}

class ReaderList extends StatefulWidget {
  final String text;
  final ReadPageManager readPageManager;
  ReaderList({Key key, this.text, this.readPageManager}) : super(key: key);

  @override
  _ReaderListState createState() => _ReaderListState();
}

class _ReaderListState extends State<ReaderList> {
  int currentIndex = 0;

  List<String> text;
  @override
  void initState() {
    super.initState();

    text = wordWrap(widget.readPageManager.text);

    widget.readPageManager.addListener(reset);
  }

  void reset() {
    this.text = wordWrap(widget.readPageManager.text);
    print("reset");
    setState(() {
      currentIndex = 0;
      controller.animateTo(indexOffset(currentIndex),
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  List<int> wordlengths = [];

  List<String> wordWrap(String text) {
    List<String> result = [];

    for (String word in text.split(".")) {
      result.add(word + ".");

      wordlengths.add(word.length);
    }
    return result;
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex++;

          if (currentIndex >= text.length - 1) {
            currentIndex = 0;
          }
          print(indexOffset(currentIndex));
          // controller.animateTo(indexOffset(currentIndex),
          //     duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        });
      },
      onDoubleTap: () {
        if (currentIndex < 0) {
          currentIndex = 0;
        }
        setState(() {
          currentIndex--;
          controller.animateTo(indexOffset(currentIndex),
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        });
      },
      child: Container(
          child: ListView.builder(
        controller: controller,
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        itemCount: text.length,
        itemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Opacity(
              opacity: i == currentIndex ? 1 : 0.3,
              child: Center(
                  child: Text(
                text[i],
                style: TextStyle(fontSize: 25, height: 1.5),
              )),
            ),
          );
        },
      )),
    );
  }

  double indexOffset(int currentIndex) {
    double combinedLengthBefore = 0;

    for (int i = 0; i < currentIndex; i++) {
      combinedLengthBefore += wordlengths[i];
    }

    return ((25 * combinedLengthBefore / 26) +
        (32 * currentIndex) +
        ((combinedLengthBefore / 28) - currentIndex * 2) * (1.5 * 25));
  }
}
