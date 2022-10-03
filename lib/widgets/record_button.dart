import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

import 'package:speech_to_text/speech_recognition_result.dart';

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class RecordButton extends StatefulWidget {
  final Stopwatch stopwatch;

  RecordButton([this.stopwatch]);

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool isRecording = false;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  FlutterSoundPlayer player = FlutterSoundPlayer();

  void startRecording() async {
    // some time later...

    if (widget.stopwatch != null) {
      widget.stopwatch.reset();

      widget.stopwatch.start();
    }
    Directory tempDir = await getExternalStorageDirectory();
    String path = '${tempDir.path}/record${ext[Codec.aacADTS.index]}';
    try {
      await recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
    } catch (e) {}
    print("Recording to $path");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    recorder.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeVideoRecording,
        device: AudioDevice.speaker);
  }

  void stopRecording() async {
    if (widget.stopwatch != null) widget.stopwatch.stop();

    await new Future.delayed(Duration(seconds: 2));

    await recorder.stopRecorder();
  }

  void playRecording(c) {
    showDialog(
        context: c,
        child: SimpleDialog(
          children: <Widget>[PlayDialog()],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.fiber_manual_record,
        color: isRecording ? Colors.red : Colors.white,
      ),
      onPressed: () {
        print("${isRecording ? "Stopping" : "Starting"} recording.");

        setState(() {
          isRecording ? stopRecording() : startRecording();
          isRecording = !isRecording;
          if (!isRecording) playRecording(context);
        });
      },
    );
  }
}

class PlayDialog extends StatefulWidget {
  @override
  _PlayDialogState createState() => _PlayDialogState();
}

class _PlayDialogState extends State<PlayDialog> {
  FlutterSoundPlayer player = FlutterSoundPlayer();

  StreamSubscription playerSubscription;
  @override
  void initState() {
    super.initState();

    player.openAudioSession(
        focus: AudioFocus.requestFocusTransient,
        category: SessionCategory.playback,
        mode: SessionMode.modeSpokenAudio,
        device: AudioDevice.speaker);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.closeAudioSession();
    player = null;
    //playerSubscription.cancel();
  }

  void start() async {
    await player.setSubscriptionDuration(Duration(milliseconds: 10));
    Directory tempDir = await getExternalStorageDirectory();
    String path = '${tempDir.path}/record${ext[Codec.aacADTS.index]}';
    await player.startPlayer(
        fromURI: path,
        codec: Codec.aacADTS,
        whenFinished: () {
          setState(() {});
        });
    player.setVolume(1);

    playerSubscription = player.onProgress.listen((event) {
      print(event.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: () {
          start();
        });
  }
}
