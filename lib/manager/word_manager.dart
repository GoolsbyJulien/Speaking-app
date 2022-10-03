import 'package:speaking_app/english_words.dart';
import 'dart:math';
import 'package:speaking_app/src/syllables.dart';

class WordManager {
  List<String> histoy = [];
   int times = 0;
   String startsWith = "";
   int minLength = -1;
   int maxLength = 999;
   WordType type = WordType.ALL;
   int numberOfSyl = 0;
   String getWord() {
    Random r = new Random();
    String word = "";
    switch (type) {
      case WordType.ALL:
        word = all[r.nextInt(all.length)];
        break;
      case WordType.NOUN:
        word = nouns[r.nextInt(nouns.length)];

        break;
      case WordType.ADJECTIVE:
        word = adjectives[r.nextInt(adjectives.length)];

        break;
    }

    if (times > all.length + 20) {
      print("Could not find word in $times" + word);
      times = 0;
      return word;
    }
    word = word.toLowerCase();
    if (!word.startsWith(
          startsWith,
        ) ||
        word.length < minLength ||
        word.length > maxLength ||
        syllables(word) < numberOfSyl) {
      times++;
      return getWord();
    } else {
      print("Found $word in $times");
      times = 0;

      return word;
    }
  }
}

enum WordType { ALL, NOUN, ADJECTIVE }
