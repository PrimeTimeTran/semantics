from googletrans import Translator

import json
import codecs
translator = Translator()

translator = Translator()

with open('../assets/en.json') as file:
    data = json.load(file)
    j = {
        'quotes': []
    }
    i = 1
    for q in data['quotes']:
        t = q['text']
        lang = translator.detect(t)
        if lang.lang == 'en' and len(t) <= 300:
            print(i, len(t), t)
            j['quotes'].append({
                'id': i,
                'text': t,
                'author': q['author']
            })
            i += 1

    with codecs.open("en.json", "w", encoding='utf8') as f:
        json.dump(j, f, ensure_ascii=False)
