import 'package:flutter/material.dart';

import 'package:semantic/widgets/highlighted_text.dart';
import 'package:semantic/widgets/language_select.dart';

import 'package:semantic/classes/quote.dart';

class QuotePanel extends StatefulWidget {
  const QuotePanel(this.quote, this.text, this.translatedQuote,
      this.changeLanguage, this.checkPhraseCompleted,
      {super.key});
  final String text;
  final Quote quote;
  final Quote translatedQuote;
  final Function changeLanguage;
  final Function checkPhraseCompleted;

  @override
  State<QuotePanel> createState() => _QuotePanelState();
}

class _QuotePanelState extends State<QuotePanel> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.quote.text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              child: SizedBox(
                child:
                    HighlightedText(widget.translatedQuote, widget.text),
              ),
            ),
          ),
          Expanded(
            child: Align(
              child: TextField(
                autofocus: true,
                controller: _controller,
                onChanged: (String value) async {
                  if (value == widget.translatedQuote.text || value == 'lt') {
                    _controller.clear();
                  }
                  widget.checkPhraseCompleted(value);
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                ),
              ),
            ),
          ),
          DropdownButtonExample(changeLanguage: widget.changeLanguage),
        ],
      ),
    );
  }
}
