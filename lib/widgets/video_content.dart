import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import 'package:semantic/classes/video.dart';

import 'package:semantic/utils/layout.dart';


List mediaUrls = [
  // 9:16
  'https://scontent-mia3-2.cdninstagram.com/o1/v/t16/f1/m82/824811606C8784E3DFCB24D6850986BD_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-mia3-2.cdninstagram.com&_nc_cat=105&vs=3373433096254398_3441332658&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC84MjQ4MTE2MDZDODc4NEUzREZDQjI0RDY4NTA5ODZCRF92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0t5aFBCUHZJV0NxYTBBRUFQc0EtNzlpWFk4WGJwUjFBQUFGFQICyAEAKAAYABsAFQAAJpKCu6zPyfQ%2FFQIoAkMzLBdAJmZmZmZmZhgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&ccb=9-4&oh=00_AfC1Yt3MZM_hKYFbBZuY6PN_q2Scz7DsGo6sMpQwrvrVGQ&oe=63D3BFF3&_nc_sid=ca5ca4',
  'https://scontent-mia3-2.cdninstagram.com/o1/v/t16/f1/m82/514F2F092D41B994113F9F48AEF8E699_video_dashinit.mp4?efg=eyJxZV9ncm91cHMiOiJbXCJpZ193ZWJfZGVsaXZlcnlfdnRzX290ZlwiXSIsInZlbmNvZGVfdGFnIjoidnRzX3ZvZF91cmxnZW4uNzIwLmNsaXBzLmJhc2VsaW5lIn0&_nc_ht=scontent-mia3-2.cdninstagram.com&_nc_cat=109&vs=1120930408592826_4236133015&_nc_vs=HBksFQIYT2lnX3hwdl9yZWVsc19wZXJtYW5lbnRfcHJvZC81MTRGMkYwOTJENDFCOTk0MTEzRjlGNDhBRUY4RTY5OV92aWRlb19kYXNoaW5pdC5tcDQVAALIAQAVABgkR0s4UVRBZnpiS1JZOXRZRUFBTEFwZEtjN3VnWGJwUjFBQUFGFQICyAEAKAAYABsAFQAAJsippY6Oxt0%2FFQIoAkMzLBdAN3dLxqfvnhgSZGFzaF9iYXNlbGluZV8xX3YxEQB1%2FgcA&ccb=9-4&oh=00_AfAaxid0T1me8sWyHddY8v_pQ_aHgMSBZKtBbnJUl1kMaQ&oe=63D47F3C&_nc_sid=ca5ca4',
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
  late FocusNode _focus;
  late List<Video> videos = [];
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    getVids();
    configVideo();
    _focus = FocusNode();

    Future.delayed(const Duration(milliseconds: 500), () {
      _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    _focus.dispose();
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

  toggleSound() {
    print('Toggle');
    if (_controller.value.volume == 0) {
      _controller.setVolume(.5);
    } else {
      _controller.setVolume(0);
    }
  }

  up() {
    print('up');
    _controller.setVolume(_controller.value.volume + .1);
  }

  down() {
    print('down');
    _controller.setVolume(_controller.value.volume - .1);
  }

  next() {
    print('next');
    mediaUrls.shuffle();
    _startVideoPlayer(mediaUrls[0]);
  }

  togglePlay() {
    print('play/pause');
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = useMobileLayout(context);

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

    if (isMobile) {
      return GestureDetector(
        onTap: togglePlay,
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
      );
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyM): toggleSound,
        const SingleActivator(LogicalKeyboardKey.keyN): next,
        const SingleActivator(LogicalKeyboardKey.arrowUp): up,
        const SingleActivator(LogicalKeyboardKey.arrowDown): down,
        const SingleActivator(LogicalKeyboardKey.arrowRight): next,
        const SingleActivator(LogicalKeyboardKey.space): togglePlay,
      },
      child: Focus(
        autofocus: true,
        focusNode: _focus,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: togglePlay,
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
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          text,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 600,
                                          child: Divider(
                                            height: 40,
                                            thickness: 1,
                                            indent: 20,
                                            endIndent: 0,
                                            color: Colors.black,
                                          ),
                                        ),
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
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text('spacebar - play/pause, '),
                                const Text('n / → - next, '),
                                const Text('m - mute, '),
                                const Text('↑ - volume + '),
                                const Text('↓ - volume - '),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
