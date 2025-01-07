import 'package:flutter/material.dart';
import '../../models/joke_model.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;
  final Function(Joke) onFavoritePressed;

  JokeCard({required this.joke, required this.onFavoritePressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(joke.setup),
        subtitle: Text(joke.punchline),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () => onFavoritePressed(joke),
        ),
      ),
    );
  }
}
