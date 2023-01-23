// ignore: avoid_web_libraries_in_flutter
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

changeLangTo(v) {
  if (v == 'Vietnamese 🇻🇳') {
    v = 'vi';
  } else if (v == 'Spanish 🇪🇸') {
    v = 'es';
  } else if (v == 'Chinese 🇨🇳') {
    v = 'zh-cn';
  }
  return v;
}
