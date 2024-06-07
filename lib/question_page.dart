import 'package:build_with_ai_workshop/home_page.dart';
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
  int playerScore = 0;

  String selectedAnswer = "";

  QuestionModel? get _getCurrentQuestion =>
      widget.questions.elementAtOrNull(currentQuestion);

  void onQuestionClick(String answer) async {
    print((widget.questions.length - 1) == currentQuestion);
    if ((widget.questions.length - 1) == currentQuestion) {
      await showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Dialog(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 30, right: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Game Finished",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Your Score is ( $playerScore / ${widget.questions.length} )",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w300),
                        ),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text("Back to Home"))
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
      return;
    }
    if (answer == _getCurrentQuestion?.correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Correct"),
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.green,
      ));
      playerScore++;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Wrong"),
        duration: Duration(milliseconds: 800),
        backgroundColor: Colors.red,
      ));
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
            Row(
              children: [
                const Spacer(),
                Text(_getCurrentQuestion?.question ?? ""),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            "${currentQuestion + 1}/${widget.questions.length}")))
              ],
            ),
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
