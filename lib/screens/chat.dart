import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';

class Quote {
  final String body;
  final DateTime created;
  Quote(this.body, this.created);
  Quote.fromSnapshot(Map<String, dynamic> json)
      : created = DateTime.parse(json['created']),
        body = json['body'];
}

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  late List quotes = [];
  late String text = '';
  FocusNode myFocusNode = FocusNode();

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.ref('quotes');

    ref.limitToLast(10).onValue.listen((DatabaseEvent event) {
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
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter message'),
            controller: _controller,
            focusNode: myFocusNode,
            onSubmitted: (value) {
              _controller.clear();

              var q = {"created": DateTime.now().toString(), "body": text};
              DatabaseReference ref = FirebaseDatabase.instance.ref('quotes');
              var val = ref.push();
              val.set(q);
              setState(() {
                text = '';
              });
              myFocusNode.requestFocus();
            },
            onChanged: (value) {
              setState(() {
                text = value;
              });
            },
          ),
        )
      ],
    );
  }
}
