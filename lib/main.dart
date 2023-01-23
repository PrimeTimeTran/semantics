import 'dart:async';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:semantic/widgets/nav_bar.dart';
import 'package:semantic/screens/composer.dart';
import 'package:semantic/widgets/my_drawer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
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
  const MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget body = const Composer();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    logEvents();
  }

  drawerChange(v) {
    setState(() {
      body = v;
    });
  }

  logEvents() async {
    await widget.analytics.logAppOpen();
    await widget.analytics.logScreenView(
      screenName: 'quotes-page',
    );
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
      drawer: MyDrawer(drawerChange: drawerChange),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(150, 10, 150, 10),
              child: body,
            ),
          ),
          Container(
            height: 50,
            color: Colors.grey.shade200,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: const Text('Bug/Feature Request'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
