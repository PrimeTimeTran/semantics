// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:faker/faker.dart';

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
      print('Localhost using emulator');
    }
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in Loi');
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

  static createFavorite() async {
    DatabaseReference ref2 = db.ref('quotes');

    var go = ref2.push();
    go.set({"body": faker.job.title()});
  }
}
