// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FB {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static FirebaseDatabase db = FirebaseDatabase.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static logStart() async {
    await analytics.logAppOpen();
    await analytics.logScreenView(
      screenName: 'quotes-page',
    );
  }

  static pageView(v) async {
    await analytics.logScreenView(
      screenName: v,
    );
  }

  static configAuth() async {
    if (window.location.hostname == 'localhost') {
      await auth.useAuthEmulator('localhost', 9099);
      db.useDatabaseEmulator('localhost', 9000);
    }
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('Not Authenticated');
      } else {
        print('Authenticated');
      }
    });
  }

  static signedIn() {
    return auth.currentUser != null;
  }

  static signOut() {
    auth.signOut();
  }

  static logSignIn() async {
    await analytics.logLogin(loginMethod: 'Email & Password');
  }

  static logSignUp() async {
    await analytics.logSignUp(signUpMethod: 'Email & Password');
  }

  static completeQuote() async {
    await analytics.logEvent(name: 'complete-quote');
  }
}
