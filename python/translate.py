from googletrans import Translator

import json

import codecs
translator = Translator()

dict = {}

with open('../assets/en.json') as file:
    data = json.load(file)
    j = {
        'quotes': []
    }
    i = 1
    for q in data['quotes']:
      text = q['text'].strip()
      text = translator.translate(text, src='en', dest='vi')
      print(i, len(text.text), text.text)
      j['quotes'].append({
          'id': i,
          'text': text.text,
          'author': q['author']
      })
      i += 1
      with codecs.open("vi.json", "w", encoding='utf8') as f:
          json.dump(j, f, ensure_ascii=False)
