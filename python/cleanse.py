from googletrans import Translator
import json
import codecs
translator = Translator()

dict = {}

translator = Translator()

with open('../assets/quotes.json') as file:
    data = json.load(file)
    j = {
        'quotes': []
    }
    i = 1
    for q in data['quotes']:
        print(i, q['text'])
        lang = translator.detect(q['text'])
        if lang.lang == 'en' and len(q['text']) <= 500:
            j['quotes'].append({
                'id': i,
                'text': q['text'],
                'author': q['author']
            })
            i+=1

    with codecs.open("output.json", "w", encoding='utf8') as f:
        json.dump(j, f, ensure_ascii=False)
