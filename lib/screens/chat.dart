import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class Quote {
  final String body;
  Quote(this.body);
  Quote.fromSnapshot(Map<String, dynamic> json) : body = json['body'];
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late List quotes = [];
  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref('quotes');

    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateQuotes(data);
    });
  }

  updateQuotes(values) {
    List q = [];
    values.forEach((key, v) {
      q.add(Quote.fromSnapshot(v));
    });
    setState(() {
      quotes = q;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text('Hi'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(quotes[index].body),
              );
            },
          ),
        ),
      ],
    );
  }
}
