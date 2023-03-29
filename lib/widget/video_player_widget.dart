import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_sample/widget/custom_controll_widget.dart';
import 'package:video_player_sample/widget/video_controls_widget.dart';
import 'package:video_player_sample/widget/video_progress_indicator.dart';

class VideoPlayerWidget extends StatefulWidget {
  final List<Duration> timestamps;

  const VideoPlayerWidget({required this.timestamps, Key? key})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();

}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
    );

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(controller),
                VideoControlsWidget(controller: controller),
                CustomVideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  timestamps: widget.timestamps,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          CustomControlsWidget(
            controller: controller,
            timestamps: widget.timestamps,
          ),
          const SizedBox(height: 12),
        ],
      );
}
