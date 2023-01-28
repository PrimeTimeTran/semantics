import 'package:flutter/material.dart';
import 'package:semantic/screens/calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:semantic/screens/composer.dart';
import 'package:semantic/screens/feed.dart';
import 'package:semantic/screens/dashboard.dart';
import 'package:semantic/screens/settings.dart';

import '../screens/chat.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer(
      {super.key, required this.drawerChange, required this.changeLang});

  final Function drawerChange;
  final Function changeLang;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Semantic Stoic'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(AppLocalizations.of(context)!.home),
            onTap: () {
              widget.drawerChange(const Composer());
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.feed),
            title: Text(AppLocalizations.of(context)!.feed),
            onTap: () {
              widget.drawerChange(const Feed());
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: Text(AppLocalizations.of(context)!.completed),
            onTap: () {
              widget.drawerChange(const Dashboard());
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.chat_outlined),
            title: Text(AppLocalizations.of(context)!.chat),
            onTap: () {
              widget.drawerChange(const Chat());
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: Text(AppLocalizations.of(context)!.history),
            onTap: () {
              widget.drawerChange(const Calendar());
              Navigator.pop(context);
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(color: Colors.grey),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              widget.drawerChange(const Settings());
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            child: Text(AppLocalizations.of(context)!.toggle),
            onPressed: () {
              widget.changeLang();
            },
          )
        ],
      ),
    );
  }
}
