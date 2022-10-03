class Script {
  String text;

  Script(this.text);
  List<String> toWordList() {
    return text.split(" ");
  }
}
