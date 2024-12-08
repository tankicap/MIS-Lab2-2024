import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/jokes.dart';
import 'screens/random_joke.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/jokes': (context) => JokesScreen(
            jokeType: ModalRoute.of(context)!.settings.arguments as String),
        '/random-joke': (context) => RandomJokeScreen(),
      },
    );
  }
}
