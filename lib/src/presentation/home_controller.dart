import 'dart:typed_data';
import 'package:build_with_ai_workshop/src/presentation/result_page.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import 'package:build_with_ai_workshop/main.dart';

enum RecipeStatus { initial, loading, success, failure }

class RecipeController extends ChangeNotifier {
  RecipeController._();
  static final RecipeController instance = RecipeController._();

  final List<XFile> imageFiles = [];

  RecipeStatus status = RecipeStatus.initial;

  List<String> selectedCuisineChips = [];
  List<String> cuisineOptions = [
    'asian',
    'mexican',
    'italian',
    'egyptian',
  ];
  List<String> languageOptions = ['Arabic', 'English', 'German'];
  List<String> selectedLanguageChips = [];

  void onSelectionLanguageChanged(List<String> newSelectedChips) {
    selectedLanguageChips = newSelectedChips;
    notifyListeners();
  }

  Future<XFile?> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    var imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      debugPrint(apiKey);
      return imagePicked;
    } else {
      debugPrint('No image selected.');
    }
    return null;
  }

  void onImageSelected(
    int? index,
  ) {
    getImageFromGallery().then((value) {
      if (value != null) {
        if (index != null) {
          imageFiles[index] = value;
        } else {
          imageFiles.add(value);
        }
        notifyListeners();
      }
    });
  }

  Future<void> generateRecipeDetailsWithAI(context) async {
    try {
      status = RecipeStatus.loading;
      notifyListeners();

      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

      // Write the prompt here
      // I have the following dietary restrictions: None
      // Optionally also include the following ingredients: none
      final prompt = TextPart('''
Recommend a recipe for me based on the provided image  .
The recipe should only contain real, edible ingredients.

If the image or images attached don't contain any food items, respond to say that you cannot recommend a recipe with inedible ingredients.

Adhere to food safety and handling best practices like ensuring that poultry is fully cooked.

Use this Language to text generated : ${selectedLanguageChips.join(', ')}

Use the following types of cuisine: {${selectedCuisineChips.join(', ')}}

After providing the recipe, explain creatively why the recipe is good based on only the ingredients used in the recipe. 

Provide a summary of how many people the recipe will serve and the the nutritional information per serving.
List out any ingredients that are potential allergens.
''');
      List<DataPart> imageParts = await generateDataPartsFromImages(imageFiles);

      if (imageParts.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Please select an image to generate the recipe details!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      var promptContent = Content.multi([prompt, ...imageParts]);
      var result = await model.generateContent([promptContent]);

      /// Show a success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recipe Details Generated Successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      /// Navigate to the result page
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return ResultPage(
          result: result.text ?? "",
          isArabic: selectedLanguageChips.contains('Arabic'),
        );
      }));
    } on Exception catch (e) {
      debugPrint('Error: $e');

      status = RecipeStatus.failure;
      notifyListeners();
    } finally {
      status = RecipeStatus.success;
      notifyListeners();
    }
  }

  Future<List<DataPart>> generateDataPartsFromImages(
      List<XFile> imagesFiles) async {
    final List<Uint8List> imageBytes = [];
    for (var image in imagesFiles) {
      final bytes = await image.readAsBytes();
      imageBytes.add(bytes);
    }
    final List<DataPart> imageParts = [];
    for (var image in imageBytes) {
      imageParts.add(DataPart('image/jpeg', image));
    }
    return imageParts;
  }

  String handleTheJsonTag(String text) {
    if (text.contains("```json")) {
      return text.replaceAll('```json', '').replaceAll('```', '');
    }
    return text;
  }

  void resetResult() {
    imageFiles.clear();
    selectedCuisineChips.clear();
    selectedLanguageChips.clear();
    notifyListeners();
  }

  onImageRemoved(int index) {
    imageFiles.removeAt(index);
    notifyListeners();
  }

  void onSelectionCuisineChanged(List<String> value) {
    selectedCuisineChips = value;
    notifyListeners();
  }
}
