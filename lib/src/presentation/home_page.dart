import 'package:build_with_ai_workshop/src/presentation/home_controller.dart';
import 'package:build_with_ai_workshop/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final RecipeController recipeController;
  const HomePage({Key? key, required this.recipeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Recipe with AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListenableBuilder(
          listenable: recipeController,
          builder: (context, __) => Column(
            children: [
              ImagesPickContainer(
                onImageSelected: recipeController.onImageSelected,
                onImageRemoved: recipeController.onImageRemoved,
                imageFiles: recipeController.imageFiles,
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomChips(
                    title: 'Cuisine Options:',
                    options: recipeController.cuisineOptions,
                    selectedChips: recipeController.selectedCuisineChips,
                    isSingleSelection: true,
                    onSelectionChanged:
                        recipeController.onSelectionCuisineChanged,
                  ),
                  const SizedBox(height: 20),
                  CustomChips(
                    title: 'Language:',
                    options: recipeController.languageOptions,
                    selectedChips: recipeController.selectedLanguageChips,
                    isSingleSelection: true,
                    onSelectionChanged:
                        recipeController.onSelectionLanguageChanged,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LoadingOrResultWidget(
                isLoading: recipeController.status == RecipeStatus.loading,
                resultWidget: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CustomButton(
                      onPressed: () async => await recipeController
                          .generateRecipeDetailsWithAI(context),
                      buttonText: "Generate Recipe",
                      textColor: Colors.black,
                      borderColor: Colors.black,
                    ),
                    CustomButton(
                      visible: recipeController.imageFiles.isNotEmpty,
                      onPressed: recipeController.resetResult,
                      buttonText: "Reset",
                      textColor: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
