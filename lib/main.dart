import 'dart:async';
import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'tabs_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class Quote {
  final String text;
  final String author;

  Quote(this.text, this.author);

  Quote.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        author = json['author'];

  Map<String, dynamic> toJson() => {
        'text': text,
        'author': author,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semantics',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Semantics',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  late List<Quote> quotes = [
    Quote('Foo', 'bar'),
    Quote('Spam', 'ham'),
  ];
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future getQuotes() async {
    final String response = await rootBundle.loadString('assets/quotes.json');
    final data = await json.decode(response)['quotes'];
    var quotes = new List<Quote>.from(data.map((x) => Quote.fromJson(x)));
    quotes.shuffle();
    return quotes;
  }
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/quotes.json');
  //   final data = await json.decode(response)['quotes'];
  //   var quotes = new List<Quote>.from(data.map((x) => Quote.fromJson(x)));
  //   print('Hii Loi, the reasJson beeing CaLLED');
  //   print(quotes[0].text);
  //   setState(() {
  //     quotes = quotes;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // this.readJson();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(quotes.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
                autofocus: true,
                onChanged: (String value) async {
                  print('Hello World');
                  debugPrint(value);
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      if (ConnectionState.active != null && !snapshot.hasData) {
                        return Center(child: Text('Loading'));
                      }

                      return ListView.builder(
                        itemCount: snapshot.data.length % 20,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: FlutterLogo(),
                            title: SelectableText(snapshot.data[index].text),
                            subtitle: Text(snapshot.data[index].author),
                          );
                          return Text(snapshot.data[index].text);
                        },
                      );
                    },
                    future: getQuotes(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<TabsPage>(
              settings: const RouteSettings(name: TabsPage.routeName),
              builder: (BuildContext context) {
                return TabsPage(widget.observer);
              },
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }
}
