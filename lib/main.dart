import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';  // Генериран од Firebase ако го користиш
import 'screens/favorite_jokes.dart';
import 'screens/home.dart';
import 'providers/favorite_jokes_provider.dart';
import 'screens/jokes.dart';
import 'screens/random_joke.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализација на Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Ако користиш firebase_options.dart
  );

  // Инициализација на NotificationService
  await NotificationService().initialize();

  // Започни ја апликацијата
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteJokesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Шега на денот',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/jokes': (context) => JokesScreen(
            jokeType: ModalRoute.of(context)!.settings.arguments as String),
        '/random-joke': (context) => RandomJokeScreen(),
        '/favorites': (context) => FavoriteJokesScreen(),
      },
    );
  }
}
