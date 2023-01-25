# Semantic Stoic

Quizlet/Kahoot/Duolingo/LeetCode tool for learning a language and mental health/Blinkist//content

## Dependencies

- NPM
- Flutter
- Firebase CLI

# WIP

- [x] Add feed page
- [x] As a user I see questions and answers on each video.
- [ ] As a user I must answer a question on each video. May have different levels, easy, medium, hard.
- [ ] As a user I see the next video play when I answer a question.

Backlog:

- Gamify answering questions on videos.
- Comments on videos.
- Create todo list.
- Add saved phrases screen.
- Add metrics screen.
- Add most saved quotes screen.
- Add admin screen for creating lessons. Lessons are videos, questions, answers.
- Add phrases types. ie motivational, stoic, joke, fact, elementary
- Challenge mode

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
