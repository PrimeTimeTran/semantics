import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class Message {
  final String body;
  final DateTime created;
  Message(this.body, this.created);
  Message.fromSnapshot(Map<String, dynamic> json)
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
      updateMessages(data);
    });
  }

  updateMessages(values) {
    List q = [];
    values.forEach((key, v) {
      q.add(Message.fromSnapshot(v));
    });
    setState(() {
      quotes = q;
    });
  }

  onSubmit() {
    _controller.clear();
    var q = {"created": DateTime.now().toString(), "body": text};
    DatabaseReference ref = FirebaseDatabase.instance.ref('quotes');
    var val = ref.push();
    val.set(q);
    setState(() {
      text = '';
    });
    myFocusNode.requestFocus();
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
            decoration: const InputDecoration(hintText: 'Enter message'),
            controller: _controller,
            focusNode: myFocusNode,
            onSubmitted: (value) {
              onSubmit();
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
