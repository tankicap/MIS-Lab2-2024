import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/joke_model.dart';
import '../providers/favorite_jokes_provider.dart';

class FavoriteJokesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access favorite jokes from the provider
    final favoriteJokes = Provider.of<FavoriteJokesProvider>(context).favoriteJokes;

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Jokes')),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('No favorite jokes added yet!'))
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          final joke = favoriteJokes[index];

          return ListTile(
            title: Text(joke.setup),
            subtitle: Text(joke.punchline),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Remove from favorites using the provider
                Provider.of<FavoriteJokesProvider>(context, listen: false)
                    .removeFromFavorites(joke);
              },
            ),
          );
        },
      ),
    );
  }
}
