import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class FavoriteJokesProvider with ChangeNotifier {
  final Set<Joke> _favoriteJokes = {};

  List<Joke> get favoriteJokes => List.unmodifiable(_favoriteJokes);


  void addToFavorites(Joke joke) {
    _favoriteJokes.add(joke);
    notifyListeners(); // Notify listeners to update UI
  }


  void removeFromFavorites(Joke joke) {
    _favoriteJokes.remove(joke);
    notifyListeners(); // Notify listeners to update UI
  }
}
