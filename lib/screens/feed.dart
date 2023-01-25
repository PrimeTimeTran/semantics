import 'package:flutter/material.dart';

import 'package:semantic/widgets/video_content.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: VideoContent());
  }
}
