
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ResultPage extends StatelessWidget {
  final String result;
  final bool isArabic;
  const ResultPage({
    Key? key,
    required this.result,
    required this.isArabic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Generated'),
      ),
      body: SafeArea(
        child: Center(
            child: Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Markdown(
            data: result,
          ),
        )),
      ),
    );
  }
}
