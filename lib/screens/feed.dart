import 'package:flutter/material.dart';
import 'dart:async';

import 'package:video_player/video_player.dart';

List mediaUrls = [
  // 9:16
  'https://assets.mixkit.co/videos/preview/mixkit-man-runs-past-ground-level-shot-32809-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-red-frog-on-a-log-1487-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-woman-running-above-the-camera-on-a-running-track-32807-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-two-avenues-with-many-cars-traveling-at-night-34562-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-under-a-peripheral-road-with-two-avenues-on-the-sides-34560-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-city-traffic-on-bridges-and-streets-34565-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-womans-silhouette-walking-on-the-beach-at-sunset-1214-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-portrait-of-a-woman-in-a-pool-1259-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-a-woman-walking-on-the-beach-on-a-sunny-day-1208-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-womans-portrait-wearing-a-bikini-at-the-beach-1215-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-a-woman-in-a-bikini-in-front-of-a-tiled-1263-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-basketball-player-dribbling-then-dunking-2285-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-basketballs-being-shot-in-a-street-rink-2286-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-circuit-board-2381-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-woman-walking-by-a-pool-3157-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-woman-sitting-on-the-edge-of-a-pool-3158-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-machinery-of-a-very-close-watch-3673-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-mist-at-the-base-of-a-snowy-mountain-3308-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-snow-falling-in-a-pine-forest-3352-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-old-street-at-night-3456-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-woman-sitting-reading-in-pajamas-4950-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-young-sportsman-jumping-rope-at-home-5050-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-domino-effect-on-dark-background-5253-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-man-playing-with-a-tower-of-poker-chips-5251-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-candies-in-a-waffle-cone-on-a-yellow-background-10368-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-hand-holding-a-rubik-cube-that-seems-to-melt-on-13765-large.mp4',

  // 16:9
  // 'https://assets.mixkit.co/videos/preview/mixkit-beach-front-with-children-playing-2176-large.mp4',
  // 'https://assets.mixkit.co/videos/preview/mixkit-one-on-one-basketball-game-751-large.mp4',
  // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
];

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    mediaUrls.shuffle();
    _controller = VideoPlayerController.network(mediaUrls[0])
      ..initialize().then((_) {
        _controller.addListener(() {
          checkDone();
        });
        setState(() {});
      });
    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.setVolume(0);
    });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.pause().then((_) {
      _controller.dispose();
    });
    super.dispose();
  }

  checkDone() {
    bool done = !_controller.value.isPlaying &&
        _controller.value.isInitialized &&
        (_controller.value.duration == _controller.value.position);
    if (done) {
      print('Done');
      mediaUrls.shuffle();
      _startVideoPlayer(mediaUrls[0]);
      setState(() {});
    }
  }

  void _initController(String link) {
    _controller = VideoPlayerController.network(link)
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          checkDone();
        });
        _controller.play();
      });
  }

  Future<void> _startVideoPlayer(String link) async {
    if (_controller.value.isInitialized) {
      await _controller.dispose();
    }

    _initController(link);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }
}
