import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

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
  String text = '';
  final TextEditingController _controller = TextEditingController();
  late List<Quote> quotes = [];
  late List<Quote> nativeQuotes = [];
  Quote focused = Quote(0, '', '');

  @override
  void initState() {
    super.initState();
    logEvents();
    getQuotes();
  }

  logEvents() async {
    await analytics.logAppOpen();
    await analytics.logScreenView(
      screenName: 'quotes-page',
    );
  }

  Future getQuotes() async {
    final String response = await rootBundle.loadString('assets/vi.json');
    final data = await json.decode(response)['quotes'];
    var q = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    q.shuffle();
    print(q.length.toString());
    print(q[0].id);
    print(q[0].text);
    q = List.from(q.take(5));
    setState(() {
      quotes = q;
    });
    getViQuotes();
  }

  Future getViQuotes() async {
    final String response = await rootBundle.loadString('assets/en.json');
    final data = await json.decode(response)['quotes'];
    var q = List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    setState(() {
      nativeQuotes = q;
    });
    setFocused();
  }

  setFocused() {
    var f = nativeQuotes.firstWhere((element) => element.id == quotes[0].id);
    setState(() {
      focused = f;
    });
  }

  checkPhraseCompleted() {
    if (text == quotes[0].text) {
      quotes.removeAt(0);
      setState(() {
        text = '';
        quotes = quotes;
      });
      _controller.clear();
      setFocused();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        focused != null
            ? Text(
                focused.text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              )
            : Container(),
        TextField(
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
            hintText: 'Enter a search term',
          ),
        ),
        SizedBox(
          height: 550,
          child: ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              var t = quotes[index].text;
              var newText;
              if (index == 0) {
                int length = text.length;
                var textPrefix = text.take(length);
                var prefix = t.take(length);

                var idx = equalUntil(textPrefix, prefix);
                var sameChar = textPrefix.length > 0 &&
                    prefix.length > 0 &&
                    textPrefix[idx] == prefix[idx];
                newText = Row(children: [
                  Text(t.take(idx),
                      style:
                          const TextStyle(
                          backgroundColor: Colors.lightBlue, fontSize: 30)),
                  idx == length
                      ? Text('')
                      : Text(t.from(idx, length),
                          style: TextStyle(
                              backgroundColor:
                                  sameChar ? Colors.lightBlue : Colors.red,
                              fontSize: 30)),
                  Text(
                    t.from(0 + length, t.length),
                    style: TextStyle(fontSize: 30),
                  )
                ]);
              }
              return ListTile(
                title: index == 0 ? newText : SelectableText(t),
                subtitle: Text(quotes[index].author),
              );
            },
          ),
        ),
      ],
    );
  }
}
