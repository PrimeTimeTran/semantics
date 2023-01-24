# Semantic Stoic

Quizlet/Kahoot/Duolingo/LeetCode tool for learning a language and mental health/Blinkist//content

## Dependencies

- NPM
- Flutter
- Firebase CLI

# WIP 
- [x] Add feed page
- [] Next video when question completed
- [] As a user I must answer a question on each video. May have different levels, easy, medium, hard.
- [] Multiple questions on videos


Backlog:

- Create todo list.
- Add saved phrases screen.
- Add metrics screen.
- Add most saved quotes screen.
- Add admin edit screen.
- Add phrases types. ie motivational, stoic, joke, fact, elementary

Done:

- Add highlight right portion of string typed.
- Add highlight wrong portion of string typed.
- As a user I can choose language I'm practicing. vi, es, zh, etc.
- Add completed phrases screen
- Add Authentication.

app = {
  currentUser: {
    favorites: [],
    completed: [],
    decks: [],
  },
  videos: {
    questions: [
      {
        videoId: 1,
        type: Multiple Choice, True/False, Multi Select, Short Answer
        body: 'What is she doing'
        level: e, m, h
      }
    ]
  }
  deck: {
    name: '',
    quotes: [],
  },
  quote: {
    text: '',
    last: '',
    next: '',
    author: '',
  },
  notions: {
    pages: [],
  },
  class Todo {
    String body;
    bool done;
  }
}
