import 'package:build_with_ai_workshop/main.dart';
import 'package:build_with_ai_workshop/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class RecipeGeneratedPage extends StatefulWidget {
  const RecipeGeneratedPage({super.key});

  @override
  State<RecipeGeneratedPage> createState() => _RecipeGeneratedPageState();
}

class _RecipeGeneratedPageState extends State<RecipeGeneratedPage> {
  XFile? _imageFile;

  Future<XFile?> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    _imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (_imageFile != null) {
      setState(() {});
      debugPrint(_imageFile?.path);
      debugPrint(apiKey);
      return _imageFile;
    } else {
      debugPrint('No image selected.');
    }
    return null;
  }

  Future<void> generateRecipeDetailsWithAI() async {
    try {
      final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
      final imageBytes = await _imageFile?.readAsBytes();
      final prompt = TextPart('''{Write here the Prompt}''');
      if (imageBytes == null) {
        throw Exception('No image selected.');
      }
      final imageParts = DataPart('image/jpeg', imageBytes);
      final response = await model.generateContent([
        Content.multi([prompt, imageParts])
      ]);
      final String resultString =
          response.text?.replaceAll('```json', '').replaceAll('```', '') ??
              "{}";
    } on Exception catch (e) {
      debugPrint('Error: $e');
    }
  }

  void setValueGenerated(RecipeModel product) {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe Details Generated Successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      /// Write here the implementation code
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details with AI'),
      ),
      backgroundColor: Colors.black12,
      body: const Center(
        child: Text("Recipe App"),
      ),
    );
  }
}
