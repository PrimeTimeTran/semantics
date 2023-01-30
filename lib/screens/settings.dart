import 'package:flutter/material.dart';

import 'package:semantic/utils/firebase.dart';

import 'package:semantic/screens/auth_panel.dart';

const List<String> list = <String>['English 🇺🇸', 'Vietnamese 🇻🇳'];

class Settings extends StatefulWidget {
  Settings({super.key, this.changeLang});

  Function? changeLang;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String dropdownValue = list.first;
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
        ? Column(
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blue),
                underline: Container(
                  height: 2,
                  color: Colors.lightBlueAccent,
                ),
                onChanged: (String? value) {
                  // print(value);
                  widget.changeLang!();
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              MaterialButton(onPressed: signOut, child: const Text('Sign Out')),
            ],
          )
        : const AuthPanel();
  }
}
