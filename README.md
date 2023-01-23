# Semantic Stoic

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Backlog:

- Create todo list.
- Add saved phrases screen.
- Add metrics screen.
- Add Authentication.
- Add most saved quotes screen.
- Add admin edit screen.
- Add phrases types. ie motivational, stoic, joke, fact, elementary

Done:

- Add highlight right portion of string typed.
- Add highlight wrong portion of string typed.
- As a user I can choose language I'm practicing. vi, es, zh, etc.
- Add completed phrases screen

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
