# Semantic Stoic

Quizlet/Kahoot/Duolingo/LeetCode tool for learning a language and mental health/Blinkist//content

## Dependencies

- NPM
- Dart
- Flutter
- Firebase CLI

## WIP

- [ ] As a user I see a daily quote counter in the top right.
- [ ] As a user I see the next video play when I answer a question.
- [ ] As a user I must answer a question on each video. May have different levels, easy, medium, hard.

Backlog:

- [ ] Challenge mode.
- [ ] Create todo list.
- [ ] Add metrics screen.
- [ ] Comments on videos.

- [ ] Add saved phrases screen.
- [ ] User can set their homepage.
- [ ] Add most saved quotes screen.
- [ ] User can choose light or dark moore.
- [ ] Gamify answering questions on videos.
- [ ] Persist volume settings across _controllers.
- [ ] Add phrases types. ie motivational, stoic, joke, fact, elementary
- [ ] Add admin screen for creating lessons. Lessons are videos, questions, answers.

Done:

- [x] Add feed page.
- [x] Add authentication.
- [x] Add completed phrases screen.
- [x] Add highlight right portion of string typed.
- [x] Add highlight wrong portion of string typed.
- [x] As a user I can choose language I'm practicing. vi, es, zh, etc.
- [x] As a user I see questions and answers on each video.

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
