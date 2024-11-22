// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:simple_player/model/simple_player_settings.dart';

import 'playback_speed_options.dart';

class SettingsScreen extends StatefulWidget {
  double speed;
  SimplePlayerSettings settings;
  bool comfortModeOn;
  bool showButtonsOn;
  void Function()? onExit;
  final ValueSetter<bool> comfortClicked;
  final ValueSetter<double> speedSelected;
  final ValueSetter<bool> showButtons;

  SettingsScreen({
    Key? key,
    required this.speed,
    required this.settings,
    required this.comfortModeOn,
    required this.showButtonsOn,
    required this.onExit,
    required this.comfortClicked,
    required this.speedSelected,
    required this.showButtons,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /// ReturnValue
  void _onExit() => widget.onExit!();

  void _comfortCallBack(bool value) => widget.comfortClicked(value);

  void _speedCallBack(double value) => widget.speedSelected(value);

  void _showButtonsCallBack(bool value) => widget.showButtons(value);

  @override
  Widget build(BuildContext context) {
    return Container(
      ///  Standardized color so that it does not harm the user's eyes.
      color: Colors.black38,
      child: Center(
        child: Container(
          ///  Maximum display size.
          constraints: const BoxConstraints(maxWidth: 400),

          ///  Spacers that provide a more pleasant layout.
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(

              ///  Standardized color so that it does not harm the user's eyes.
              color: Colors.grey[850]!,
              borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: AspectRatio(
            ///  The controller has its standard appearance
            ///  so that it does not suffer from distortions
            ///  in the display on tablets and other
            ///  smartphones with peculiar sizes.
            aspectRatio: 16 / 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: widget.settings.brightnessSlider),
                Expanded(
                  child: PlaybackSpeedOptions(
                    speed: widget.speed,
                    colorAccent: widget.settings.playBackSpeedColor,
                    speedSelected: (value) => _speedCallBack(value),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 4,
                  indent: 8,
                  endIndent: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Here, the show buttons button is locked
                      /// to this button so that an accidental
                      /// bump on the screen causes a bad user experience.
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          tooltip: 'Mostrar botões',
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          splashColor: widget.settings.playBackSpeedColor,
                          icon: Icon(Icons.visibility,
                              color: widget.showButtonsOn
                                  ? Colors.orange
                                  : Colors.white),
                          onPressed: () {
                            _showButtonsCallBack(true);
                          },
                        ),
                      ),

                      ///  Here, a yellow filter is applied
                      ///  so that the user can avoid blue
                      ///  light at night or an eventual eye strain.
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          tooltip: 'Modo conforto',
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          splashColor: Colors.orangeAccent,
                          icon: Icon(Icons.nights_stay,
                              color: widget.comfortModeOn
                                  ? Colors.orange
                                  : Colors.white),
                          onPressed: () {
                            _comfortCallBack(!widget.comfortModeOn);
                          },
                        ),
                      ),

                      ///  The 'ExitButton' of the options widget
                      ///  is locked to this button so that an accidental
                      ///  bump on the screen causes a bad user experience.
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          tooltip: 'Sair',
                          splashRadius: 20,
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          splashColor: widget.settings.playBackSpeedColor,
                          icon: Icon(Icons.exit_to_app_rounded,
                              color: widget.settings.playBackSpeedColor),
                          onPressed: () => _onExit(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
