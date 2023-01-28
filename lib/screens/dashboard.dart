import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

import 'package:semantic/widgets/utils.dart';

import 'package:semantic/classes/quote.dart';

import '../utils/layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<QuoteRecord> quotes = [];

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  Future getQuotes() async {
    var data = await readCompleted();
    var d = jsonDecode(data);
    var q = List<QuoteRecord>.from(
        d.map((x) => QuoteRecord.fromJson(jsonDecode(x))));
    setState(() {
      quotes = q;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = useMobileLayout(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 0 : 20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: quotes.length,
                
                itemBuilder: (context, index) {
                  final item = quotes[index];

                  return Dismissible(
                    key: Key(item.date.toString()),
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      setState(() {
                        quotes.removeAt(index);
                      });

                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item dismissed')));
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            quotes[index].quote.text,
                            style: TextStyle(fontSize: isMobile ? 15 : 30),
                          ),
                          subtitle: Text(
                            quotes[index].translatedQuote.text,
                            style: TextStyle(fontSize: isMobile ? 15 : 30),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                          trailing: Text(
                            quotes[index].date
                                .format(payload: "MMM Do YY", forceLocal: true)
                                .toString(),
                            style: TextStyle(fontSize: isMobile ? 10 : 30),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
