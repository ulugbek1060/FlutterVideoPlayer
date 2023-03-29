import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef DurationChanger = Duration? Function(Duration? duration);

class CustomControlsWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final List<Duration> timestamps;

  const CustomControlsWidget({
    required this.controller,
    required this.timestamps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(const Icon(Icons.fast_rewind), rewindToPosition),
            const SizedBox(width: 12),
            buildButton(const Icon(Icons.replay_5), rewind5Seconds),
            const SizedBox(width: 12),
            buildButton(const Icon(Icons.forward_5), forward5Seconds),
            const SizedBox(width: 12),
            buildButton(const Icon(Icons.fast_forward), forwardToPosition),
          ],
        ),
      );

  Widget buildButton(Widget child, VoidCallback onPressed) => Container(
        height: 50,
        width: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      );

  Future rewindToPosition() async {
    if (timestamps.isEmpty) return;
    Duration rewind(Duration? currentPosition) => timestamps.lastWhere(
          (element) => currentPosition! > element + const Duration(seconds: 2),
          orElse: () => Duration.zero,
        );

    await goToPosition(rewind);
  }

  Future forwardToPosition() async {
    if (timestamps.isEmpty) return;
    Duration forward(Duration? currentPosition) => timestamps.firstWhere(
          (position) => currentPosition! < position,
          orElse: () => const Duration(days: 1),
        );

    await goToPosition(forward);
  }

  Future forward5Seconds() async => goToPosition((currentPosition) {
        if (currentPosition == null) return null;
        return currentPosition + const Duration(seconds: 5);
      });

  Future rewind5Seconds() async => goToPosition((currentPosition) {
        if (currentPosition == null) return null;
        return currentPosition - const Duration(seconds: 5);
      });

  Future goToPosition(DurationChanger builder) async {
    final currentPosition = await controller.position;
    final newPosition = builder(currentPosition);
    if (newPosition == null) return;
    await controller.seekTo(newPosition);
  }
}
