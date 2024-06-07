import 'package:build_with_ai_workshop/firebase_options.dart';
import 'package:build_with_ai_workshop/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// Get the API key from the environment.
const String apiKey = String.fromEnvironment('API_KEY');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x004285f4)),
        useMaterial3: false,
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
