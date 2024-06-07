import 'dart:convert';

import 'package:build_with_ai_workshop/main.dart';
import 'package:build_with_ai_workshop/question_page.dart';
import 'package:build_with_ai_workshop/questions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: MaterialButton(
        height: 60,
        minWidth: 300,
        onPressed: onGenerateGame,
        color: const Color(0xfff9ab00),
        child: const Text(
          "Generate Game",
          style: TextStyle(color: Color(0xff000000), fontSize: 20),
        ),
      )),
    );
  }

  void onGenerateGame() async {
    try {
      EasyLoading.show(status: 'Generating The Game ');
      final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      const prompt =
          '''generate 10 questions game for the flutter topic , response back with a direct json  representation, the json should have these properties {questions: List { question_name: String, answers: List<String>, correct_answer:String }}, 4 answers with short text max length 30 characters  if they are available.''';

      final response = await model.generateContent([
        Content.text(
          prompt,
        )
      ]);
      final String resultString =
          response.text?.replaceAll('```json', '').replaceAll('```', '') ??
              "{}";

      debugPrint(resultString);

      final List<QuestionModel> questionsModel = parseQuestions(resultString);

      navigatorToQuestionGamePage(questionsModel);
    } on Exception catch (e) {
      debugPrint('Error: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void navigatorToQuestionGamePage(List<QuestionModel> questionsModel) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsPage(
          questions: questionsModel,
        ),
      ),
      (route) => false,
    );
  }
}

List<QuestionModel> parseQuestions(String jsonString) {
  final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  final List<dynamic> questionsJson =
      jsonMap['questions']; // Access the nested list

  return questionsJson
      .map((questionJson) => QuestionModel.fromJson(questionJson))
      .toList();
}
