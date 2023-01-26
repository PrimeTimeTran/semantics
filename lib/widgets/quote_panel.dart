import 'package:flutter/material.dart';

import 'package:semantic/widgets/highlighted_text.dart';
import 'package:semantic/widgets/language_select.dart';

import 'package:semantic/classes/quote.dart';

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
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    final bool useMobileLayout = shortestSide < 600;
    
    return Padding(
      padding: EdgeInsets.all(useMobileLayout ? 5 : 150),
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
                    TextStyle(
                  fontSize: useMobileLayout ? 25 : 35,
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
                focusNode: _focus,

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
