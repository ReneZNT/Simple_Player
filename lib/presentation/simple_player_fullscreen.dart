import 'package:flutter/material.dart';
import 'package:simple_player/simple_player.dart';
import 'package:video_player/video_player.dart';

import '../aplication/simple_aplication.dart';
import '../constants/constants.dart';
import '../model/simple_player_state.dart';
import 'widgets/settings_screen.dart';

class SimplePlayerFullScreen extends StatefulWidget {
  final SimpleController simpleController;
  final SimplePlayerSettings simplePlayerSettings;
  final SimplePlayerState simplePlayerState;

  const SimplePlayerFullScreen(
      {Key? key,
      required this.simpleController,
      required this.simplePlayerSettings,
      required this.simplePlayerState})
      : super(key: key);

  @override
  State<SimplePlayerFullScreen> createState() => _SimplePlayerFullScreenState();
}

class _SimplePlayerFullScreenState extends State<SimplePlayerFullScreen>
    with SingleTickerProviderStateMixin {
  /// Classes and Packages
  SimpleAplication simpleAplication = SimpleAplication();
  late SimplePlayerSettings simplePlayerSettings;
  Constants constants = Constants();

  /// Attributes
  late SimpleController simplePlayerController = widget.simpleController;
  late VideoPlayerController _videoPlayerController;
  late AnimationController _animationController;
  double? _currentSeconds = 0.0;
  double? _totalSeconds = 0.0;
  double? lastSpeed = 1.0;
  String? _showTime = '-:-';
  String? _tittle = '';
  bool? _visibleSettings = false;

  // bool? _visibleControls = true;
  bool? _wasPlaying = false;
  bool? _confortMode = false;
  bool? _playbackSetUp = false;

  //lister VideoPlayerController errors and update SimpleController
  void _listenError() {
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.hasError) {
        simplePlayerController.setError(true);
      }
    });
  }

  /// Listen to the speed of the video.
  void listenSpeed() {
    simplePlayerController.listenSpeed().listen((event) {
      if (lastSpeed != event) {
        lastSpeed = event;
        _speedSetter(event);
      }
    });
  }

  String convertSecondsToReadableString(int milliseconds) {
    try {
      int seconds = milliseconds ~/ 1000;
      int m = seconds ~/ 60;
      if (m > 999) {
        return 'N:T';
      }
      int s = seconds % 60;
      if (s > 59) {
        return 'N:T';
      }
      String result = "$m:${s > 9 ? s : "0$s"}";
      return result;
    } catch (e) {
      return 'N:T';
    }
  }

  /// Control settings block display.
  _showScreenSettings() {
    bool playing = _videoPlayerController.value.isPlaying;
    if (_visibleSettings! && !playing) {
      /// play
      if (_wasPlaying!) {
        _playAndPauseSwitch();

        /// Hide the control interface
        setState(() => _visibleSettings = false);
      } else {
        /// Hide the control interface
        setState(() => _visibleSettings = false);
      }
    } else if (!_visibleSettings! && playing) {
      /// pause
      _playAndPauseSwitch();

      /// Switch to displaying the control interface
      setState(() => _visibleSettings = true);
    } else if (!_visibleSettings!) {
      /// Switch to displaying the control interface
      setState(() => _visibleSettings = true);
    }
  }

  /// Controls whether or not to force image distortion.
  double _aspectRatioManager(VideoPlayerController controller) {
    /// Check if there is a predefined AspectRatio
    if (simplePlayerSettings.forceAspectRatio!) {
      return simplePlayerSettings.aspectRatio!;
    } else {
      return controller.value.aspectRatio;
    }
  }

  /// Controls the video playback speed.
  _speedSetter(double? speed) async {
    setState(() => lastSpeed = speed);
    if (simplePlayerController.speed != speed) {
      simplePlayerController.setSpeed(speed!);
    }
    _videoPlayerController.setPlaybackSpeed(speed!);
  }

  /// Responsible for sending all data to the environment in full screen.
  _fullScreenManager() async {
    SimplePlayerState simplePlayerState = SimplePlayerState(
        currentSeconds: _currentSeconds,
        totalSeconds: _totalSeconds,
        speed: lastSpeed,
        showTime: _showTime,
        label: _tittle,
        autoPlay: simplePlayerSettings.autoPlay,
        loopMode: simplePlayerSettings.loopMode,
        wasPlaying: _videoPlayerController.value.isPlaying,
        confortMode: _confortMode);

    /// FullScreenDisable
    await simpleAplication.hideNavigation(false);

    /// UnlockRotation
    simpleAplication.lockAndUnlockScreen(lock: false).then((value) {
      Navigator.of(context).pop(simplePlayerState);
    });
  }

  /// Retrieves and inserts the last state of the previous screen
  _lastState() {
    SimplePlayerState simplePlayerState = widget.simplePlayerState;

    setState(() {
      lastSpeed = simplePlayerState.speed;
      _tittle = simplePlayerState.label;
      _wasPlaying = simplePlayerState.wasPlaying;
      _confortMode = simplePlayerState.confortMode;
    });

    /// Methods
    _videoPlayerController.setLooping(simplePlayerState.loopMode!);
    _jumpTo(simplePlayerState.currentSeconds!);
    _speedSetter(simplePlayerState.speed);
    _configureRotation();
  }

  _configureRotation() {
    /// Check the Aspect Ratio of the video
    /// being played back to define whether
    /// to keep the display in landscape or portrait mode

    double ratio = _videoPlayerController.value.aspectRatio;
    simpleAplication.lockAndUnlockScreen(lock: true, aspectRatio: ratio);

    /// Release the display of the interface
    setState(() {
      _playbackSetUp = true;
    });
  }

  ///  Sends playback to the specified point.
  _jumpTo(double value) {
    _videoPlayerController.seekTo(Duration(milliseconds: value.toInt()));

    if (_wasPlaying!) {
      _playAndPauseSwitch();
    }
  }

  ///  Extremely precise control of all animations
  ///  in conjunction with play and pause of playback.
  _playAndPauseSwitch({bool pauseButton = false}) {
    bool playing = _videoPlayerController.value.isPlaying;
    if (playing) {
      /// pause
      if (pauseButton) {
        _wasPlaying = !playing;
      } else {
        _wasPlaying = playing;
      }
      _animationController.reverse();
      _videoPlayerController.pause();
    } else {
      /// play
      _wasPlaying = playing;
      _animationController.forward();
      _videoPlayerController.play();
    }
  }

  /// Responsible for correct initialization of all controllers.
  _setupControllers(SimplePlayerSettings simplePlayerSettings) {
    /// Video controller
    _videoPlayerController = simpleAplication.getControler(simplePlayerSettings)
      ..initialize().then(
        (_) {
          setState(() {
            _totalSeconds =
                _videoPlayerController.value.duration.inMilliseconds.toDouble();
          });

          /// Methods after settings
          _lastState();

          /// Listen errors
          _listenError();
        },
      );

    /// Icons controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  /// Update the real-time seconds counter on replay.
  _secondsListener() {
    _videoPlayerController.addListener(
      () {
        widget.simpleController.updateController(_videoPlayerController);
        bool playing = _videoPlayerController.value.isPlaying;
        if (_currentSeconds == _totalSeconds && !playing) {
          _animationController.reverse();
          _jumpTo(0.0);
        }
        setState(() {
          _currentSeconds = _videoPlayerController.value.position.inMilliseconds
                      .toDouble() <
                  0
              ? 0.0
              : _videoPlayerController.value.position.inMilliseconds.toDouble();
          _showTime = convertSecondsToReadableString(
              _videoPlayerController.value.position.inMilliseconds);
        });
      },
    );

    listenSpeed();
  }

  /// Shows or hides the HUB from controller commands.
  _listenerPlayFromController() {
    String changeTime = '';
    widget.simpleController.listenPlayAndPause().listen((event) {
      if (changeTime != event) {
        changeTime = event;
      }
    });
  }

  /// Responsible for starting the interface
  _initializeInterface() {
    simplePlayerSettings = widget.simplePlayerSettings;

    /// Methods
    _setupControllers(simplePlayerSettings);
    _secondsListener();
    _listenerPlayFromController();
  }

  @override
  void initState() {
    /// Method responsible for initializing
    /// all methods in the correct order
    _initializeInterface();
    super.initState();
  }

  @override
  void dispose() {
    _dismissConstrollers();
    super.dispose();
  }

  /// Finalize resources
  _dismissConstrollers() async {
    _animationController.stop();
    _animationController.dispose();
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: Colors.black,
        child: _playbackSetUp!
            ? Container(
                width: width,
                color: Colors.black,
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio:
                            _aspectRatioManager(_videoPlayerController),
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                    _videoPlayerController.value.isInitialized
                        ? Center(
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return FadeTransition(
                                      opacity: animation, child: child);
                                },
                                child: simplePlayerController.show
                                    ? AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        key: const ValueKey('a'),
                                        color: _confortMode!
                                            ? Colors.deepOrange.withOpacity(0.1)
                                            : Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    _tittle!,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      shadows: [
                                                        Shadow(
                                                          blurRadius: 10.0,
                                                          color: Colors.black,
                                                          offset:
                                                              Offset(3.0, 2.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  icon: const Icon(
                                                    Icons.settings_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _showScreenSettings();
                                                  },
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: IconButton(
                                                    icon: AnimatedIcon(
                                                        size: 15,
                                                        color: Colors.white,
                                                        icon: AnimatedIcons
                                                            .play_pause,
                                                        progress:
                                                            _animationController),
                                                    onPressed: () =>
                                                        _playAndPauseSwitch(
                                                            pauseButton: true),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: SliderTheme(
                                                  data: constants
                                                      .getSliderThemeData(
                                                    settings:
                                                        simplePlayerSettings,
                                                  ),
                                                  child: Slider.adaptive(
                                                    value: _currentSeconds ?? 0,
                                                    max: _totalSeconds ?? 0,
                                                    min: 0,
                                                    label: _currentSeconds
                                                        .toString(),
                                                    onChanged: (double value) {
                                                      _jumpTo(value);
                                                    },
                                                  ),
                                                )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    _showTime!,
                                                    style: TextStyle(
                                                        color:
                                                            simplePlayerSettings
                                                                .timeColor),
                                                  ),
                                                ),
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  icon: Icon(
                                                    Icons.fullscreen,
                                                    color: simplePlayerSettings
                                                        .iconFullScreenColor,
                                                  ),
                                                  onPressed: () =>
                                                      _fullScreenManager(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    : AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        key: const ValueKey('a'),
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    _tittle!,
                                                    style: TextStyle(
                                                      color:
                                                          simplePlayerSettings
                                                              .titleColor,
                                                      fontSize: 16,
                                                      shadows: const [
                                                        Shadow(
                                                          blurRadius: 10.0,
                                                          color: Colors.black,
                                                          offset:
                                                              Offset(3.0, 2.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  icon: Icon(
                                                      Icons.settings_outlined,
                                                      color: simplePlayerSettings
                                                          .iconSettingColor),
                                                  onPressed: () {
                                                    _showScreenSettings();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _visibleSettings!
                          ? SettingsScreen(
                              settings: simplePlayerSettings,
                              speed: lastSpeed!,
                              confortModeOn: _confortMode!,
                              showButtonsOn: simplePlayerController.show,
                              onExit: () => _showScreenSettings(),
                              showButtons: (value) => setState(
                                  () => simplePlayerController.showButtons()),
                              confortClicked: (value) =>
                                  setState(() => _confortMode = value),
                              speedSelected: (value) => _speedSetter(value),
                            )
                          : const SizedBox(width: 1, height: 1),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
