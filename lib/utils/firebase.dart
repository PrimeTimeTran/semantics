// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FB {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
      
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
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      print('Localhost using emulator');
    }
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in Loi');
      }
    });
  }

  static signedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static signOut() {
    FirebaseAuth.instance.signOut();
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
