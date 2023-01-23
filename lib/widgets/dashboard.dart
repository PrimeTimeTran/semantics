import 'package:flutter/material.dart';
import 'dart:html'; 

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Storage _localStorage = window.localStorage;

  Future save() async {
    _localStorage['selected_id'] = 'woow this gonna woork';
  }

  Future invalidate() async {
    _localStorage.remove('selected_id');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          child: Text('hi'),
          onPressed: () {
            print('So');
            save();
          },
        )
      ],
    );
  }
}
