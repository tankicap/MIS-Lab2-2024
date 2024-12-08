import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';
import '../widgets/joke/joke_card.dart';

class JokesScreen extends StatelessWidget {
  final String jokeType;

  JokesScreen({required this.jokeType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$jokeType Jokes')),
      body: FutureBuilder<List<Joke>>(
        future: ApiService.fetchJokesByType(jokeType),
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
                return JokeCard(joke: jokes[index]);
              },
            );
          }
        },
      ),
    );
  }
}
