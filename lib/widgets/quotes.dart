import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
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

class _QuotesState extends State<Quotes> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    logEvents();
  }

  logEvents() async {
    await analytics.logAppOpen();
    await analytics.logScreenView(
      screenName: 'quotes-page',
    );
  }

  Future<List<Quote>> getQuotes() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final data = await json.decode(response)['quotes'];
    var quotes = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    quotes.shuffle();
    print(quotes.length.toString());
    print(quotes[0].text);
    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quote>>(
      future: getQuotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: SizedBox(
              height: 750,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const FlutterLogo(),
                    title: SelectableText(snapshot.data![index].text),
                    subtitle: Text(snapshot.data![index].author),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(child: Text('Loading'));
        }
      },
    );
  }
}
