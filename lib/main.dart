import 'package:build_with_ai_workshop/generate_product_details_page.dart';
import 'package:flutter/material.dart';

/// Get the API key from the environment.
const String apiKey = String.fromEnvironment('API_KEY');
void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const GenerateImageDetails(),
    );
  }
}

