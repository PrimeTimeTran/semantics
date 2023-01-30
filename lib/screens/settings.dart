import 'package:flutter/material.dart';

import 'package:semantic/utils/firebase.dart';

import 'package:semantic/screens/auth_panel.dart';

const List<String> list = <String>['English 🇺🇸', 'Vietnamese 🇻🇳'];

class Settings extends StatefulWidget {
  const Settings({super.key, this.changeLang});

  final Function? changeLang;

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.blueAccent),
                      ),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(hintText: 'John'),
                              ),
                            ),
                            SizedBox(width: 50),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(hintText: 'Doe'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: TextField(
                                decoration:
                                    InputDecoration(hintText: 'john@email.com'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
              SizedBox(height: 20),
              MaterialButton(
                onPressed: signOut,
                child: const Text('Sign Out'),
                color: Colors.redAccent,
              ),
            ],
          )
        : const AuthPanel();
  }
}
