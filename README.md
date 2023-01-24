# Semantic Stoic


## Dependencies

- NPM
- Flutter
- Firebase CLI

Backlog:

- Add feed page
  - Questions oon videos
  - Multiple questions on videos
  - Next video
  - 
  
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
