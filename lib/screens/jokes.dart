import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';
import '../widgets/joke/joke_card.dart';
import 'favorite_jokes.dart';
import '../providers/favorite_jokes_provider.dart';

class JokesScreen extends StatefulWidget {
  final String jokeType;

  JokesScreen({required this.jokeType});

  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType} Jokes'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to FavoriteJokesScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(widget.jokeType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data!;

            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  joke: jokes[index],
                  onFavoritePressed: (joke) {
                    // Add joke to favorites
                    Provider.of<FavoriteJokesProvider>(context, listen: false)
                        .addToFavorites(joke);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}