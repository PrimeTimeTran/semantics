import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'package:semantic/classes/video.dart';

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
  'https://assets.mixkit.co/videos/preview/mixkit-young-sportsman-jumping-rope-at-home-5050-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-domino-effect-on-dark-background-5253-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-man-playing-with-a-tower-of-poker-chips-5251-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-candies-in-a-waffle-cone-on-a-yellow-background-10368-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-hand-holding-a-rubik-cube-that-seems-to-melt-on-13765-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-artist-painting-an-abstract-portrait-5271-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-portrait-of-a-ballerina-in-ballet-pose-40162-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-portrait-man-on-a-call-working-in-an-office-44748-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-girl-on-a-ladder-plays-the-guitar-and-smiles-straight-13759-large.mp4',

  // 16:9
  // 'https://assets.mixkit.co/videos/preview/mixkit-beach-front-with-children-playing-2176-large.mp4',
  // 'https://assets.mixkit.co/videos/preview/mixkit-one-on-one-basketball-game-751-large.mp4',
  // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
];

class VideoContent extends StatefulWidget {
  const VideoContent(
      {Key? key, this.index = 0, this.id = '0', this.discover = false})
      : super(key: key);
  final String id;
  final int index;
  final bool discover;

  @override
  State<VideoContent> createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  late VideoPlayerController _controller;
  late List<Video> videos = [];

  @override
  void initState() {
    super.initState();
    getVids();
    configVideo();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  getVids() async {
    final String response = await rootBundle.loadString('assets/videos.json');
    final data = await json.decode(response)['videos'];
    List<Video> vids = List<Video>.from(data.map((x) => Video.fromJson(x)));
    vids.shuffle();
    setState(() {
      videos = vids;
    });
  }

  void configVideo() {
    mediaUrls.shuffle();
    final url = mediaUrls[0];
    _controller = VideoPlayerController.network(url)
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

  shuffleVideos() {
    videos.shuffle();
    setState(() {
      videos = videos;
    });
  }

  void checkDone() {
    if (_controller.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      // debugPrint('video Started');
    }

    if (!_controller.value.isPlaying &&
        _controller.value.duration == _controller.value.position) {
      // debugPrint('video Ended');
      mediaUrls.shuffle();
      _startVideoPlayer(mediaUrls[0]);

      setState(() {});
    }
  }

  void _initController(String link) {
    _controller = VideoPlayerController.network(link)
      ..initialize().then((_) {
        videos.shuffle();
        setState(() {
          videos = videos;
        });
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var text = '';
    var ans1 = '';
    var ans2 = '';
    var ans3 = '';
    var ans4 = '';
    if (videos.isNotEmpty) {
      text = videos.first.questions?.first.body ?? '';
      ans1 = videos.first.questions?.first.ans?.first.body ?? '';
      ans2 = videos.first.questions?.first.ans?[1].body ?? '';
      ans3 = videos.first.questions?.first.ans?[2].body ?? '';
      ans4 = videos.first.questions?.first.ans?[3].body ?? '';
    }
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                },
                child: AbsorbPointer(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      children: [
                        _controller.value.isInitialized
                            ? SizedBox(
                                width: width,
                                height: height * .83,
                                child: VideoPlayer(_controller),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_controller.value.isInitialized)
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                            backgroundColor: Colors.red,
                            bufferedColor: Colors.black,
                            playedColor: Colors.blue),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: videos.isNotEmpty
              ? SizedBox(
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            text,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(ans1),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(ans2),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(ans3),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(ans4),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
