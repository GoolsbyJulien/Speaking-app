import 'package:speaking_app/english_words.dart';

class ScriptManager {
  static int currentWord = 0;
  static Script currentScript = new Script(
      "April is the cruelest month. Though TS Eliot, the great English poet, wrote: it in a philosophical vein but it is true for students too, most of whom have their exams in the month of March and April.So many thoughts pass through the minds of students within a little time before the exam begins. A scene before the examination hall presents an interesting sight because we can witness various kinds of students in their various fluctuating moods. About half an hour before the exam, the students begin to arrive at the examination center. Generally they are accompanied by their parents and relatives. The candidates exchange greetings with their friends. Many of the students still remain very busy with their books. Some of them discuss their problems loudly and in anxious moods. Very few of them are confident and look around quietly. The first bell rings and the hustle-bustle gradually come to a halt. The students leave their books outside and enter the examination hall. With the second bell, question papers are distributed. There is perfect silence in the examination hall for three hours, except for one or the other student asks for supplementary sheets, water or permission to go to the toilet. When the time is over, the strain of anxiety disappears and instead a note of relief can be perceived amid the loud discussions and chattering of students.");
  static void reset() {
    currentWord = 0;
  }

  static String getWord() {
    if (currentWord > currentScript.toWordList().length) reset();
    currentWord++;
    return currentScript.toWordList()[currentWord - 1];
  }

  static void setScript(Script s) {
    currentScript = s;
    reset();
  }
}
