import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:semantic/widgets/highlighted_text.dart';
import 'package:semantic/widgets/language_select.dart';

import 'package:semantic/widgets/utils.dart';

import 'package:semantic/classes/quote.dart';

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
    if (text == quote.text || text == 'lt') {
      saveAsCompleted(quote.toJson());
      getQuotes();
      _controller.clear();
      setTranslatedQuote();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                translatedQuote.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
          ),
          Expanded(
            child: Align(
              child: SizedBox(
                child: HighlightedText(quote, text),
              ),
            ),
          ),
          Expanded(
            child: Align(
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
          ),
          DropdownButtonExample(changeLanguage: changeLanguage),
        ],
      ),
    );
  }
}
