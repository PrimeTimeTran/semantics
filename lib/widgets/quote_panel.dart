import 'package:flutter/material.dart';

import 'package:semantic/widgets/highlighted_text.dart';
import 'package:semantic/widgets/language_select.dart';

import 'package:semantic/classes/quote.dart';
import 'package:semantic/utils/layout.dart';

class QuotePanel extends StatefulWidget {
  const QuotePanel(this.quote, this.text, this.translatedQuote,
      this.changeLanguage, this.checkPhraseCompleted, this.nextQuote,
      {super.key});
  final String text;
  final Quote quote;
  final Quote translatedQuote;
  final Function changeLanguage;
  final Function checkPhraseCompleted;
  final Function nextQuote;

  @override
  State<QuotePanel> createState() => _QuotePanelState();
}

class _QuotePanelState extends State<QuotePanel> {
  late FocusNode _focus;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();

    Future.delayed(const Duration(milliseconds: 500), () {
      _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = useMobileLayout(context);

    return Padding(
      padding: EdgeInsets.all(isMobile ? 5 : 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                widget.quote.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 25 : 35,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              child: HighlightedText(widget.translatedQuote, widget.text),
            ),
          ),
          Expanded(
            flex: 1,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: TextField(
                autofocus: true,
                focusNode: _focus,
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '',
                ),
                onChanged: (String value) async {
                  if (value == widget.translatedQuote.text || value == 'lt') {
                    _controller.clear();
                  }
                  widget.checkPhraseCompleted(value);
                },
              ),
            ),
          ),
          DropdownButtonExample(changeLanguage: widget.changeLanguage),
        ],
      ),
    );
  }
}
