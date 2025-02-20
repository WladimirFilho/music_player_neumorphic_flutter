import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class PlayControlController extends GetxController {
  // State variables
  final isPlaying = false.obs;
  final soundTimeStamp = const Duration().obs;
  final finalSoundTimeStamp = const Duration().obs;
  final percentage = 0.0.obs;

  // Attribute variables
  final AudioPlayer audioPlayers;
  // ignore: unused_field
  late StreamSubscription<Duration> _durationSubscription;

  PlayControlController({
    required this.audioPlayers,
  }) : super() {
    _durationSubscription =
        audioPlayers.onPositionChanged.listen((event) async {
      soundTimeStamp.value = event;
      final duration = await audioPlayers.getDuration() ?? const Duration();

      final musicPercentageProgressBar = event.inSeconds / duration.inSeconds;
      percentage.value = musicPercentageProgressBar;

      if (musicPercentageProgressBar == 1) {
        isPlaying.value = false;
      }
    });
  }

  // Play music
  void playMusic() async {
    isPlaying.value = !isPlaying.value;
    if (isPlaying.value) {
      await audioPlayers.play(
        AssetSource('music/mixkit-woodfire-by-the-lake-128.mp3'),
      );
      finalSoundTimeStamp.value =
          await audioPlayers.getDuration() ?? const Duration();
    } else {
      await audioPlayers.pause();
    }
  }

  // Next and Previous

  // Progess Bar music

  // Favorite music
}
