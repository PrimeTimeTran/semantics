import 'dart:async';
import 'package:semantic/screens/chat.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:semantic/widgets/nav_bar.dart';
import 'package:semantic/widgets/footer.dart';

import 'package:semantic/screens/composer.dart';
import 'package:semantic/screens/settings.dart';
import 'package:semantic/screens/feed.dart';
import 'package:semantic/widgets/my_drawer.dart';

import 'package:semantic/utils/firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FB.configAuth();
  FB.logStart();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semantic Stoic',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[FB.observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(title: 'Semantic Stoic'),
        '/settings': (context) => const Settings(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget body = const Composer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  drawerChange(v) {
    setState(() {
      body = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(changePage: drawerChange),
      drawer: MyDrawer(drawerChange: drawerChange),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: body,
          ),
          const Expanded(child: Footer()),
        ],
      ),
    );
  }
}
