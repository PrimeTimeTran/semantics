import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:semantic/widgets/language_select.dart';

extension StringX on String {
  String take(int nbChars) => substring(0, nbChars.clamp(0, length));
  String from(int nbChars, int typeLength) => substring(nbChars, typeLength);
}

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

class Quote {
  final int id;
  final String text;
  final String author;

  Quote(this.id, this.text, this.author);

  Quote.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        author = json['author'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'author': author,
      };
}

class Composer extends StatefulWidget {
  const Composer({Key? key}) : super(key: key);

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final TextEditingController _controller = TextEditingController();

  late List<Quote> quotes = [];
  late List<Quote> translatedQuotes = [];

  Quote quote = Quote(0, '', '');
  Quote translatedQuote = Quote(0, '', '');

  String text = '';
  String language = 'vi';

  @override
  void initState() {
    super.initState();
    logEvents();
    getQuotes();
  }

  changeLanguage(v) {
    print('changing');
    if (v == 'Vietnamese 🇻🇳') {
      v = 'vi';
    } else if (v == 'Spanish 🇪🇸') {
      v = 'es';
    } else if (v == 'Chinese 🇨🇳') {
      v = 'zh-cn';
    }

    setState(() {
      language = v;
    });
    getQuotes();
  }

  logEvents() async {
    await analytics.logAppOpen();
    await analytics.logScreenView(
      screenName: 'quotes-page',
    );
    getQuotes();
  }

  Future getQuotes() async {
    final String response =
        await rootBundle.loadString('assets/$language.json');
    final data = await json.decode(response)['quotes'];
    var quotes = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    quotes.shuffle();
    setState(() {
      quotes = quotes;
      quote = quotes[0];
    });
    setTranslatedQuotes();
  }

  Future setTranslatedQuotes() async {
    final String response = await rootBundle.loadString('assets/en.json');
    final data = await json.decode(response)['quotes'];
    var quotes = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    setState(() {
      text = '';
      translatedQuotes = quotes;
    });
    setTranslatedQuote();
  }

  setTranslatedQuote() {
    var q = translatedQuotes.firstWhere((e) => e.id == quote.id);
    setState(() {
      translatedQuote = q;
    });
  }

  checkPhraseCompleted() {
    if (text == quote.text || text == 'magic') {
      getQuotes();
      _controller.clear();
      setTranslatedQuote();
    }
  }

  getHighlightedText() {
    var t = quote.text;
    RichText newText;
    int length = text.length;
    var textPrefix = text.take(length);
    var prefix = t.take(length);

    var idx = equalUntil(textPrefix, prefix);
    var sameChar = textPrefix.length > 0 &&
        prefix.length > 0 &&
        textPrefix[idx] == prefix[idx];
    newText = RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: t.take(idx),
              style: const TextStyle(
                  backgroundColor: Colors.lightBlue, fontSize: 30)),
          idx == length
              ? TextSpan(text: '')
              : TextSpan(
                  text: t.from(idx, length),
                  style: TextStyle(
                      backgroundColor: sameChar ? Colors.lightBlue : Colors.red,
                      fontSize: 30)),
          TextSpan(
            text: t.from(0 + length, t.length),
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
    return newText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                translatedQuote.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center           ,
              child: SizedBox(
                child: getHighlightedText(),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _controller,
              onChanged: (String value) async {
                setState(() {
                  text = value;
                });
                checkPhraseCompleted();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '',
              ),
            ),
          ),
          DropdownButtonExample(changeLanguage: changeLanguage),
        ],
      ),
    );
  }
}
