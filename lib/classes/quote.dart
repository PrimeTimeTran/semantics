class Quote {
  int id;
  String text;
  String author;

  Quote(this.id, this.text, this.author);

  Quote.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        author = json['author'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'author': author,
      };
}

class QuoteRecord {
  Quote quote;
  Quote translatedQuote;
  DateTime date;

  QuoteRecord(this.quote, this.translatedQuote, this.date);

  QuoteRecord.fromJson(Map<String, dynamic> json)
      : quote = Quote.fromJson(json['quote']),
        translatedQuote = Quote.fromJson(json['translatedQuote']),
        date = DateTime.parse(json['date']);
}
