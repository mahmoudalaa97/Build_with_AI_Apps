import 'package:flutter/material.dart';
import 'src/presentation/home_controller.dart';
import 'src/presentation/home_page.dart';

/// Get the API key from the environment.
const String apiKey = String.fromEnvironment('API_KEY');

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Build With AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: false,
      ),
      home: HomePage(
        recipeController: RecipeController.instance,
      ),
    );
  }
}
