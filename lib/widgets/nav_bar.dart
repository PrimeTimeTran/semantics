import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: const Text('Semantic Stoic')),
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
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        const Icon(Icons.favorite),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.search),
        ),
        const Icon(Icons.more_vert),
      ],
    );
  }
}
