import 'package:flutter/material.dart';
import 'package:semantic/screens/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:semantic/screens/settings.dart';

import 'package:semantic/utils/firebase.dart';
import 'package:semantic/widgets/utils.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  const Navbar({super.key, required this.changePage});

  final Function changePage;

  @override
  State<Navbar> createState() => _NavbarState();

  @override
  Size get preferredSize => new Size.fromHeight(100);
}

class _NavbarState extends State<Navbar> {
  @override
  void initState() {
    super.initState();
    FB.auth.authStateChanges().listen((User? user) {
      print("Listnerer");
      if (user != null) {
        print('in!');
      } else {
        print('Signout');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Center(child: Text('Semantic Stoic')),
        backgroundColor: Colors.blue,
        leading: Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Container(
              padding: const EdgeInsets.all(7.0),
              child: const Icon(Icons.menu),
            ),
          );
        }),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              numQuotesCompleted().toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          PopupMenuButton(itemBuilder: (context) {
            return FB.signedIn()
                ? [
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("My Account"),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Settings"),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ]
                : [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Sign Up/In"),
                    ),
                  ];
          }, onSelected: (value) {
            if (value == 0) {
              widget.changePage(const Settings());
            } else if (value == 1) {
              widget.changePage(const Account());
            } else if (value == 2) {
              FB.signOut();
            }
          }),
        ]);
  }
}
