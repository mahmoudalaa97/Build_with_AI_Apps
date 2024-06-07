import 'package:build_with_ai_workshop/questions_model.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, required this.questions});

  final List<QuestionModel> questions;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentQuestion = 0;

  String selectedAnswer = "";

  QuestionModel? get _getCurrentQuestion =>
      widget.questions.elementAtOrNull(currentQuestion);

  void onQuestionClick(String answer) async {
    if (answer == _getCurrentQuestion?.correctAnswer) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Correct")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Wrong")));
    }
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text(_getCurrentQuestion?.question ?? ""),
            const Spacer(),
            GridView.builder(
              itemCount: _getCurrentQuestion?.answers.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 10,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                String answer =
                    _getCurrentQuestion?.answers.elementAtOrNull(index) ?? "";
                return GestureDetector(
                  onTap: () => onQuestionClick(answer),
                  child: Container(
                    width: size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(answer),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
