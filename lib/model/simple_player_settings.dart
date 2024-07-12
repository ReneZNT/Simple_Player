import 'package:flutter/material.dart';

import '../presentation/widgets/brightness_slider.dart';

class SimplePlayerSettings {
  String? type;
  String? path;
  String? label;
  double? aspectRatio;
  bool? autoPlay;
  bool? loopMode;
  bool? forceAspectRatio;
  SliderThemeData sliderThemeData;
  double overlayOpacity;
  bool hideFrame;
  Color iconSettingColor;
  Color titleColor;
  Color iconFullScreenColor;
  Color timeColor;
  Color playPauseColor;
  BrightnessSlider brightnessSlider;
  Color playBackSpeedColor;
  EdgeInsets playPausePadding;

  SimplePlayerSettings({
    required this.type,
    required this.path,
    required this.label,
    required this.aspectRatio,
    required this.autoPlay,
    required this.loopMode,
    required this.forceAspectRatio,
    this.sliderThemeData = const SliderThemeData(
      activeTrackColor: Colors.red,
      thumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
      overlayColor: Colors.red,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.white,
    ),
    this.hideFrame = false,
    this.iconSettingColor = Colors.white,
    this.titleColor = Colors.white,
    this.iconFullScreenColor = Colors.white,
    this.timeColor = Colors.white,
    this.playPauseColor = Colors.white,
    this.brightnessSlider = const BrightnessSlider(
      colorAccent: Colors.red,
    ),
    this.playBackSpeedColor = Colors.red,
    this.overlayOpacity = 0.5,
    this.playPausePadding = const EdgeInsets.only(left: 16),
  });

  ///
  /// ## SimplePlayerSettings properties can be configured in the following ways:
  ///
  /// ### String? path;
  /// Defines the origin of the file, which can be:
  /// SimplePlayerSettings.network (Video URL)
  /// SimplePlayerSettings.assets (Path of a video file)
  ///
  /// ### String? label;
  /// Sets the title displayed at the top dropdown of the video.
  ///
  /// ### double? aspectRatio; (default 16:9)
  /// Sets SimplePlayer's aspect ratio, this can let black embroideries on the video without distorting the image.
  ///
  /// ### bool? forceAspectRatio
  /// True case: Forces the video to fit the Player's aspect ratio, this may distort the image.
  /// #### Examples:
  /// - aspectRatio: 1 / 1,
  /// - forceAspectRatio: false
  ///
  /// ![bee](https://raw.githubusercontent.com/InaldoManso/Simple_Player/main/lib/assets/bee_ratio_false.png)
  ///
  /// - aspectRatio: 1 / 1,
  /// - forceAspectRatio: true
  ///
  /// ![bee](https://raw.githubusercontent.com/InaldoManso/Simple_Player/main/lib/assets/bee_ratio_true.png)
  ///
  /// ### bool? autoPlay;
  /// If true: as soon as the Player is built the video will be played automatically.
  ///
  /// ### bool? loopMode;
  /// If true: As soon as the video finishes playing, it will restart automatically.
  ///

  factory SimplePlayerSettings.network({
    required String path,
    String? label = '',
    double? aspectRatio = 16 / 9,
    bool? autoPlay = false,
    bool? loopMode = false,
    bool? forceAspectRatio = false,
    SliderThemeData sliderThemeData = const SliderThemeData(
      activeTrackColor: Colors.red,
      thumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
      overlayColor: Colors.red,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.white,
    ),
    double overlayOpacity = 0.5,
    bool hideFrame = false,
    Color iconSettingColor = Colors.white,
    Color titleColor = Colors.white,
    Color iconFullScreenColor = Colors.white,
    Color timeColor = Colors.white,
    Color playPauseColor = Colors.white,
    BrightnessSlider brightnessSlider = const BrightnessSlider(
      colorAccent: Colors.red,
    ),
    Color playBackSpeedColor = Colors.red,
    EdgeInsets playPausePadding = const EdgeInsets.only(left: 16),
  }) {
    return SimplePlayerSettings(
      type: 'network',
      path: path,
      label: label,
      aspectRatio: aspectRatio,
      autoPlay: autoPlay,
      loopMode: loopMode,
      forceAspectRatio: forceAspectRatio,
      hideFrame: hideFrame,
      sliderThemeData: sliderThemeData,
      overlayOpacity: overlayOpacity,
      iconSettingColor: iconSettingColor,
      titleColor: titleColor,
      iconFullScreenColor: iconFullScreenColor,
      timeColor: timeColor,
      playPauseColor: playPauseColor,
      brightnessSlider: brightnessSlider,
      playBackSpeedColor: playBackSpeedColor,
      playPausePadding: playPausePadding,
    );
  }

  factory SimplePlayerSettings.assets({
    required String path,
    String? label = '',
    double? aspectRatio = 16 / 9,
    bool? autoPlay = false,
    bool? loopMode = false,
    bool? forceAspectRatio = false,
    SliderThemeData sliderThemeData = const SliderThemeData(
      activeTrackColor: Colors.red,
      thumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
      overlayColor: Colors.red,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.white,
    ),
    double overlayOpacity = 0.5,
    bool hideFrame = false,
    Color iconSettingColor = Colors.white,
    Color titleColor = Colors.white,
    Color iconFullScreenColor = Colors.white,
    Color timeColor = Colors.white,
    Color playPauseColor = Colors.white,
    BrightnessSlider brightnessSlider = const BrightnessSlider(
      colorAccent: Colors.red,
    ),
    Color playBackSpeedColor = Colors.red,
    EdgeInsets playPausePadding = const EdgeInsets.only(left: 16),
  }) {
    return SimplePlayerSettings(
      type: 'assets',
      path: path,
      label: label,
      aspectRatio: aspectRatio,
      autoPlay: autoPlay,
      loopMode: loopMode,
      forceAspectRatio: forceAspectRatio,
      hideFrame: hideFrame,
      sliderThemeData: sliderThemeData,
      overlayOpacity: overlayOpacity,
      iconSettingColor: iconSettingColor,
      titleColor: titleColor,
      iconFullScreenColor: iconFullScreenColor,
      timeColor: timeColor,
      playPauseColor: playPauseColor,
      brightnessSlider: brightnessSlider,
      playBackSpeedColor: playBackSpeedColor,
      playPausePadding: playPausePadding,
    );
  }

  factory SimplePlayerSettings.file({
    required String path,
    String? label = '',
    double? aspectRatio = 16 / 9,
    bool? autoPlay = false,
    bool? loopMode = false,
    bool? forceAspectRatio = false,
    SliderThemeData sliderThemeData = const SliderThemeData(
      activeTrackColor: Colors.red,
      thumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
      overlayColor: Colors.red,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 18),
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.white,
    ),
    double overlayOpacity = 0.5,
    bool hideFrame = false,
    Color iconSettingColor = Colors.white,
    Color titleColor = Colors.white,
    Color iconFullScreenColor = Colors.white,
    Color timeColor = Colors.white,
    Color playPauseColor = Colors.white,
    BrightnessSlider brightnessSlider = const BrightnessSlider(
      colorAccent: Colors.red,
    ),
    Color playBackSpeedColor = Colors.red,
    EdgeInsets playPausePadding = const EdgeInsets.only(left: 16),
  }) {
    return SimplePlayerSettings(
      type: 'file',
      path: path,
      label: label,
      aspectRatio: aspectRatio,
      autoPlay: autoPlay,
      loopMode: loopMode,
      forceAspectRatio: forceAspectRatio,
      hideFrame: hideFrame,
      sliderThemeData: sliderThemeData,
      overlayOpacity: overlayOpacity,
      iconSettingColor: iconSettingColor,
      titleColor: titleColor,
      iconFullScreenColor: iconFullScreenColor,
      timeColor: timeColor,
      playPauseColor: playPauseColor,
      brightnessSlider: brightnessSlider,
      playBackSpeedColor: playBackSpeedColor,
      playPausePadding: playPausePadding,
    );
  }
}
