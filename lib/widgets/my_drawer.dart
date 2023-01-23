import 'package:flutter/material.dart';

import 'package:semantic/widgets/composer.dart';
import 'package:semantic/widgets/dashboard.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key, required this.drawerChange});

  Function drawerChange;

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
            title: const Text('Home'),
            onTap: () {
              widget.drawerChange(Composer());
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              widget.drawerChange(Dashboard());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
