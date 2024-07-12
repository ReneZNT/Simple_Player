import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SimpleController extends ChangeNotifier {
  late VideoPlayerController videoPlayerController;
  late Duration position = const Duration().abs();
  bool show = true;
  String _changePlay = '';
  bool error = false;
  double speed = 1.0;

  SimpleController();

  void setError(bool value) {
    error = value;
    notifyListeners();
  }

  void setSpeed(double value) {
    speed = value;
    notifyListeners();
  }

  Stream<bool> listenError() async* {
    while (true) {
      yield error;
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  Stream<double> listenSpeed() async* {
    while (true) {
      yield speed;
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  /// ▶️ Start playing the video
  void play() {
    _changePlay = DateTime.now().toString();
    videoPlayerController.play();
    notifyListeners();
  }

  /// ⏸️ Pause video playback
  void pause() {
    _changePlay = DateTime.now().toString();
    videoPlayerController.pause();
    notifyListeners();
  }

  void showButtons() {
    show = !show;
    notifyListeners();
  }

  /// 📽️ Returning a stream of the current position of the video.
  Stream<Duration> listenPosition() async* {
    while (true) {
      yield position;
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  ///⏯️ Returning a current play and pause stream of the video.
  Stream<String> listenPlayAndPause() async* {
    while (true) {
      yield _changePlay;
      await Future.delayed(const Duration(milliseconds: 50));
    }
  }

  ///⛔ This method should not be called unless you know what it is doing. ☢️
  void updateController(VideoPlayerController controller) {
    videoPlayerController = controller;
    _setPosition(controller.value.position);
    notifyListeners();
  }

  void _setPosition(Duration value) {
    position = value;
    notifyListeners();
  }
}
