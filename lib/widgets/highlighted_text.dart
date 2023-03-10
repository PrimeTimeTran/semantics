import 'package:flutter/material.dart';

import 'package:semantic/classes/quote.dart';
import 'package:semantic/utils/layout.dart';


equalUntil(s1, s2) {
  var idx = 0;
  for (var i = 0; i < s1.length; i++) {
    for (var j = 0; j < s2.length; j++) {
      if (s1.substring(0, i) == s2.substring(0, j)) {
        idx = i;
      }
    }
  }
  return idx;
}

extension StringX on String {
  String take(int nbChars) => substring(0, nbChars.clamp(0, length));
  String from(int nbChars, int typeLength) => substring(nbChars, typeLength);
}

class HighlightedText extends StatelessWidget {
  const HighlightedText(this.quote, this.text, {super.key});

  final Quote quote;
  final String text;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = useMobileLayout(context);

    var t = quote.text;
    int length = text.length;
    var textPrefix = text.take(length);
    var prefix = t.take(length);

    var idx = equalUntil(textPrefix, prefix);
    var sameChar = textPrefix.isNotEmpty &&
        prefix.isNotEmpty &&
        textPrefix[idx] == prefix[idx];

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: isMobile ? 25 : 35,
          color: Colors.black,
        ),
        children: [
          TextSpan(
              text: t.take(idx),
              style: const TextStyle(backgroundColor: Colors.lightBlue)),
          idx == length
              ? const TextSpan(text: '')
              : TextSpan(
                  text: t.from(idx, length),
                  style: TextStyle(
                      backgroundColor:
                          sameChar ? Colors.lightBlue : Colors.red)),
          TextSpan(
            text: t.from(0 + length, t.length),
          )
        ],
      ),
    );
  }
}
