import 'dart:async';

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:semantic/widgets/footer.dart';
import 'package:semantic/widgets/nav_bar.dart';
import 'package:semantic/widgets/my_drawer.dart';

import 'package:semantic/screens/feed.dart';
import 'package:semantic/screens/charts.dart';
import 'package:semantic/screens/chat.dart';
import 'package:semantic/screens/composer.dart';
import 'package:semantic/screens/calendar.dart';
import 'package:semantic/screens/dashboard.dart';
import 'package:semantic/screens/settings.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _locale = 'en';

  toggleLang() {
    String l;
    if (_locale.toString() == 'vi') {
      l = 'en';
    } else {
      l = 'vi';
    }
    setState(() {
      _locale = l;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semantic Stoic',
      locale: Locale(_locale),
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[FB.observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) =>
            MyHomePage(title: 'Semantic Stoic', toggleLang: toggleLang),
        '/settings': (context) => const Settings(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', null),
        Locale('vi', null),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          Intl.defaultLocale = supportedLocales.first.toLanguageTag();
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            Intl.defaultLocale = supportedLocale.toLanguageTag();
            return supportedLocale;
          }
        }
        Intl.defaultLocale = supportedLocales.first.toLanguageTag();
        return supportedLocales.first;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  Function toggleLang;

  MyHomePage({
    Key? key,
    required this.title,
    required this.toggleLang,
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
      drawer:
          MyDrawer(drawerChange: drawerChange, changeLang: widget.toggleLang),
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
