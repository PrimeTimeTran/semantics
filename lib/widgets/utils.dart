import 'dart:html';
import 'dart:convert';

final Storage _localStorage = window.localStorage;

Future saveAsCompleted(q) async {
  var l = _localStorage['quotes'] ?? jsonEncode([]);

  var prev = jsonDecode(l);

  prev.add(jsonEncode(q));
  _localStorage['quotes'] = jsonEncode(prev);
}

Future readCompleted() async {
  var l = _localStorage['quotes'] ?? jsonEncode([]);
  return l;
}
