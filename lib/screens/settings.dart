import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:semantic/utils/firebase.dart';

import 'package:semantic/screens/auth_panel.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    FB.pageView('settings');
  }

  signOut() {
    FB.signOut();
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return FB.signedIn()
        ? MaterialButton(child: Text('Sign Out'), onPressed: signOut)
        : AuthPanel();
  }
}
