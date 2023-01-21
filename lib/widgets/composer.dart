import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
  String text = '';
  final TextEditingController _controller = TextEditingController();
  late Future<List<Quote>> quotes;


  @override
  void initState() {
    super.initState();
    logEvents();
    quotes = getQuotes();
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
    var q = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    q.shuffle();
    print(q.length.toString());
    print(q[0].text);
    return q;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: _controller,
          onChanged: (String value) async {
            debugPrint(value);
            setState(() {
              text = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a search term',
          ),
        ),
        SizedBox(
          height: 550,
          child: FutureBuilder(
            future: quotes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: SizedBox(
                    height: 500,
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
          ),
        ),
      ],
    );
  }
}
