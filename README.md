## Overview

Welcome to the **Build With AI Workshop**! This project showcases how to create a powerful Flutter application that leverages the Gemini API to generate detailed recipe information from an image selected from your gallery.

### Key Features

- **Image-Based Recipe Generation**: Simply select an image from your gallery, and our app will generate a detailed recipe using AI.
- **Cuisine Options**: Customize your recipe by choosing from a variety of cuisine options.
- **Language Selection**: Get your AI-generated recipe in your preferred language.

## App Preview

<p align="center">
  <img src="https://github.com/mahmoudalaa97/Build_with_AI_Apps/blob/recipes_app_with_ai/assets/en_app.png?raw=true" alt="Generate Recipe With AI" width="500">
  <img src="https://github.com/mahmoudalaa97/Build_with_AI_Apps/blob/recipes_app_with_ai/assets/ar_app.png?raw=true" alt="Generate Recipe With AI" width="500">
</p>

# How to run

### Requirements

- Dart 3.1 or above
- [Gemini API Key](https://aistudio.google.com/app/apikey)

> Note: see <https://ai.google.dev/tutorials/setup> for how to create one.

### Packages in use

- [image_picker](https://pub.dev/packages/image_picker) for pick the images form gallery
- [google_generative_ai](https://pub.dev/packages/google_generative_ai) The Google AI Dart SDK enables developers to use Google's state-of-the-art generative AI models (like Gemini) to build AI-powered features and applications.
- [flutter_markdownd](https://pub.dev/packages/flutter_markdown) A markdown renderer for Flutter

### 1. Clone the project

```shell
git clone https://github.com/mahmoudalaa97/Build_with_AI_Apps.git

git checkout recipes_app_with_ai
```

### 2. Run the project

```bash
flutter run --dart-define=API_KEY="{Here put your key}"
```

> Note: replace this "{Here put your key}" with your API Key

or

If you use VSCode, you can [specify `--dart-define`
variables](https://dartcode.org/docs/using-dart-define-in-flutter/) in your
launch.json file.

```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "build_with_ai_workshop",
            "request": "launch",
            "toolArgs": [
                "--dart-define=API_KEY={Here put your key}"
            ],
            "type": "dart"
        },
        {
            "name": "build_with_ai_workshop (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "build_with_ai_workshop (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        }
    ]
}
```

> Note: replace this {Here put your key} with your API Key

### Documentation

- [Get started with the Gemini API in Dart or Flutter apps](https://ai.google.dev/gemini-api/docs/get-started/dart)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials.
