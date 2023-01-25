import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:semantic/widgets/utils.dart';
import 'package:semantic/widgets/quote_panel.dart';

import 'package:semantic/classes/quote.dart';
import 'package:semantic/utils/firebase.dart';

class Composer extends StatefulWidget {
  const Composer({Key? key}) : super(key: key);

  @override
  State<Composer> createState() => _ComposerState();
}

class _ComposerState extends State<Composer> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

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
    print('Authenticated:');
    print(FB.signedIn());
  }

  changeLanguage(v) {
    v = changeLangTo(v);
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

  getQuotes() async {
    final String response = await rootBundle.loadString('assets/en.json');
    final data = await json.decode(response)['quotes'];
    var quotes = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    quotes.shuffle();
    setState(() {
      quotes = quotes;
      quote = quotes[0];
    });
    setTranslatedQuotes();
  }

  setTranslatedQuotes() async {
    final String response =
        await rootBundle.loadString('assets/$language.json');
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

  checkPhraseCompleted(v) {
    setState(() {
      text = v;
    });
    if (text == translatedQuote.text || text == 'lt') {
      saveAsCompleted(translatedQuote.toJson());
      getQuotes();
      setTranslatedQuote();
    }
  }

  sayHi() {
    getQuotes();
    setTranslatedQuote();
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyN): sayHi,
      },
      child: Focus(
        autofocus: true,
        child: Column(
          children: [
            Expanded(
              child: QuotePanel(quote, text, translatedQuote, changeLanguage,
                  checkPhraseCompleted),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('"n" for next quote'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
