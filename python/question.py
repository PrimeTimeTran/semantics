import codecs

from faker import Faker
import json
import random

fake = Faker()
output = {
    'questions': []
}


def createMultiSelectQuestion():
    correctAnswerId = fake.isbn10()
    correctAnswerId2 = fake.isbn10()
    ans = [
        {
            'id': correctAnswerId,
            'body': fake.sentence(nb_words=3),
        },
        {
            'id': correctAnswerId2,
            'body': fake.sentence(nb_words=3),
        },
        {
            'id': fake.isbn10(),
            'body': fake.sentence(nb_words=3),
        },
        {
            'id': fake.isbn10(),
            'body': fake.sentence(nb_words=3),
        }
    ]
    random.shuffle(ans)

    return {
        'id': fake.isbn10(),
        'type': 'ms',
        'correctAnswers': [correctAnswerId, correctAnswerId2],
        'body': fake.sentence(nb_words=5),
        'ans': ans,
    }


def createQuestion():
    correctAnswerId = fake.isbn10()
    ans = [
        {
            'id': correctAnswerId,
            'body': fake.sentence(nb_words=3),
        },
        {
            'id': fake.isbn10(),
            'body': fake.sentence(nb_words=3),
        },
        {
            'id': fake.isbn10(),
            'body': fake.sentence(nb_words=3),
        },
        {
            'id': fake.isbn10(),
            'body': fake.sentence(nb_words=3),
        }
    ]
    random.shuffle(ans)

    return {
        'id': fake.isbn10(),
        'type': 'mc',
        'body': fake.sentence(nb_words=5),
        'correctAnswerId': correctAnswerId,
        'ans': ans,
    }


def createTrueFalseQuestion():
    ans = [True, False]
    random.shuffle(ans)
    return {
        'id': fake.isbn10(),
        'type': 'tf',
        'ans': ans[0],
        'body': fake.sentence(nb_words=5),
    }


with open('./videos.json') as file:
    data = json.load(file)
    for i, url in enumerate(data['videos']):

        questions = [
            createTrueFalseQuestion(),
            createTrueFalseQuestion(),
            createQuestion(),
            createQuestion(),
            createQuestion(),
            createMultiSelectQuestion(),
            createMultiSelectQuestion(),
        ]

        random.shuffle(questions)

        v = {
            'id': i + 1,
            'videoUrl': url,
            'questions': questions,
        }

        output['questions'].append(v)

print(output)

with open("questions.json", "w") as outfile:
    json.dump(output, outfile)
