import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_services.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_jokes_provider.dart';
import '../services/notification_service.dart';

class RandomJokeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),

      ),
      body: FutureBuilder<Joke>(
        future: ApiService.fetchRandomJoke(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Joke Found'));
          } else {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    joke.setup,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    joke.punchline,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      Provider.of<FavoriteJokesProvider>(context, listen: false).addToFavorites(joke);
                    },
                    tooltip: 'Add to Favorites',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
