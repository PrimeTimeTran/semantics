import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:semantic/widgets/utils.dart';

import 'composer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Quote> quotes = [];

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  Future getQuotes() async {
    var data = await readCompleted();
    var d = json.decode(data);

    var q = List<Quote>.from(d.map((x) => Quote.fromJson(jsonDecode(x))));
    setState(() {
      quotes = q;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(quotes[index].text),
                  subtitle: Text(quotes[index].author),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
