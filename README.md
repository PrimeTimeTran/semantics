# Semantic Stoic

Quizlet/Kahoot/Duolingo/LeetCode tool for learning a language and mental health/Blinkist//content

## Dependencies

- NPM
- Dart
- Flutter
- Firebase CLI

## WIP

- [x] Add feed page
- [x] As a user I see questions and answers on each video.
- [ ] As a user I must answer a question on each video. May have different levels, easy, medium, hard.
- [ ] As a user I see the next video play when I answer a question.

Backlog:

- Challenge mode.
- Create todo list.
- Add metrics screen.
- Comments on videos.
- Add saved phrases screen.
- User can set their homepage.
- Add most saved quotes screen.
- User can choose light or dark moore.
- Gamify answering questions on videos.
- Persist volume settings across _controllers.
- Add phrases types. ie motivational, stoic, joke, fact, elementary
- Add admin screen for creating lessons. Lessons are videos, questions, answers.

Done:

- Add authentication.
- Add completed phrases screen.
- Add highlight right portion of string typed.
- Add highlight wrong portion of string typed.
- As a user I can choose language I'm practicing. vi, es, zh, etc.

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
}
