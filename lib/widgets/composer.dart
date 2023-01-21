import 'package:flutter/material.dart';

import 'package:semantic/widgets/quotes.dart';

class Composer extends StatefulWidget {
  const Composer({super.key});

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          onChanged: (String value) async {
            debugPrint(value);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
          ),
        ),
        const SizedBox(child: const Quotes()),
      ],
    );
  }
}
