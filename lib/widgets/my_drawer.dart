import 'package:flutter/material.dart';

import 'package:semantic/screens/composer.dart';
import 'package:semantic/screens/feed.dart';
import 'package:semantic/screens/dashboard.dart';
import 'package:semantic/screens/settings.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.drawerChange});

  final Function drawerChange;

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
            title: const Text('Home'),
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
            title: const Text('Feed'),
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
            title: const Text('Completed'),
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
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              widget.drawerChange(const Settings());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
