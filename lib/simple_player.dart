library simple_player;

//Packages
import 'package:simple_player/presentation/simple_player_screen.dart';
import 'package:simple_player/model/simple_player_settings.dart';
import 'package:flutter/material.dart';
//Resources
export 'model/simple_player_settings.dart';
export 'model/simple_path_type.dart';

class SimplePlayer {
  SimplePlayer();

  ///A Simple and ready to use Player!
  ///
  ///Make sure:
  ///- always call the extension: SimplePlayer.network()
  ///- perform the import do: import 'package:flutter/material.dart';
  ///
  ///To ensure a good functioning of the Package.
  ///
  ///
  ///You must pass a : SimplePlayerSettings();
  ///
  /// ```dart
  /////exmaple:
  ///
  /// String url = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  ///
  ///SimplePlayer.build(
  ///  simplePlayerSettings: SimplePlayerSettings(
  ///    simplePathType: SimplePathType.network(url: url),
  ///    label: 'Bee',
  ///    aspectRatio: 16 / 9,
  ///    autoPlay: false,
  ///    loopMode: false,
  ///    colorAccent: Colors.red
  ///  ),
  ///),
  /// ```
  ///
  /// {@tool snippet}
  ///
  /// ![bee](https://flutter.github.io/assets-for-api-docs/assets/widgets/icon.png)

  static Widget build({SimplePlayerSettings? simplePlayerSettings}) {
    return SimplePlayerScrren(simplePlayerSettings: simplePlayerSettings!);
  }
}
