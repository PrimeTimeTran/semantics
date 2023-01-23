import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import 'package:semantic/widgets/composer.dart';
import 'package:semantic/widgets/my_drawer.dart';
import 'package:semantic/widgets/nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semantic Stoic',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Semantic Stoic',
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
  @override
  void dispose() {
    super.dispose();
    logEvents();
  }

  Future<void> logEvents() async {
    await widget.analytics.logAppOpen();
    await widget.analytics.logScreenView(
      screenName: 'quotes-page',
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _launchURL() async {
    const url =
        'https://docs.google.com/forms/d/e/1FAIpQLSekPhYKaREo9vzxXcVzux0Ej-loEzLSWI9LGU2tow9vLce1Tg/viewform';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      drawer: const MyDrawer(),
      body: FooterView(
        footer: Footer(
          child: GestureDetector(
            onTap: () {
              _launchURL();
            },
            child: const Text('Bug/Feature Request'),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              children: <Widget>[
                const Composer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
