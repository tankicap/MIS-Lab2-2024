import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_services.dart';
import '../models/joke_model.dart';
import '../widgets/home/joke_type_card.dart';
import 'favorite_jokes.dart';
import 'random_joke.dart';
import '../providers/favorite_jokes_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Access favorite jokes from the provider
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteJokesScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              // Navigate to RandomJokeScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RandomJokeScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.fetchJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokeTypes = snapshot.data!;
            return ListView.builder(
              itemCount: jokeTypes.length,
              itemBuilder: (context, index) {
                return JokeTypeCard(
                  jokeType: jokeTypes[index],
                  onTap: () {
                    Navigator.pushNamed(context, '/jokes', arguments: jokeTypes[index]);
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
