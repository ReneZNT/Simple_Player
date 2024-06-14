import 'package:flutter/material.dart';

import '../model/simple_player_settings.dart';

class Constants {
  SliderThemeData getSliderThemeData({
    required SimplePlayerSettings? settings,
    Color? colorAccent,
  }) {
    SliderThemeData? currentTheme = settings?.sliderThemeData ??
        SliderThemeData(
          activeTrackColor: colorAccent ?? Colors.red,
          thumbColor: Colors.white,
          inactiveTrackColor: Colors.grey,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
          overlayColor: colorAccent ?? Colors.red,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
          activeTickMarkColor: Colors.white,
          inactiveTickMarkColor: Colors.white,
        );
    double overlayOpacity = settings?.overlayOpacity ?? 0.5;
    currentTheme = currentTheme.copyWith(
      overlayColor: currentTheme.overlayColor!.withOpacity(overlayOpacity),
    );
    return currentTheme;
  }
}
