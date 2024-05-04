import 'dart:convert';
import 'dart:io';

import 'package:build_with_ai_workshop/main.dart';
import 'package:build_with_ai_workshop/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class GenerateImageDetails extends StatefulWidget {
  const GenerateImageDetails({super.key});

  @override
  State<GenerateImageDetails> createState() => _GenerateImageDetailsState();
}

class _GenerateImageDetailsState extends State<GenerateImageDetails> {
  XFile? _imageFile;
  List<ProductModel> productGenerated = [];
  ScrollController scrollController = ScrollController();

  Future<void> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    _imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (_imageFile != null) {
      setState(() {});
      debugPrint(_imageFile?.path);
      debugPrint(apiKey);
      generateProductDetailsWithAI();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<void> generateProductDetailsWithAI() async {
    try {
      final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
      final imageBytes = await _imageFile?.readAsBytes();
      final prompt = TextPart(
          '''response back with a direct json  representation of this product image, the json should have these properties schema: {product_name: string, description: string, price: String, websites:[String]} website for user can buy this product,price with currency best price in web, if they are available.''');
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
      debugPrint(resultString);
      ProductModel product = ProductModel.fromJson(jsonDecode(resultString));
      product.imageFile = _imageFile;
      setValueGenerated(product);
    } on Exception catch (e) {
      debugPrint('Error: $e');
    }
  }

  void setValueGenerated(ProductModel product) {
    setState(() {
      productGenerated.add(product);
      _imageFile = null;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product details generated successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      if (productGenerated.length > 1) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 550,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Product Details with AI'),
      ),
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Results of Product Details Generated",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          const SizedBox(height: 20),
          Expanded(
              child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(10),
            itemCount: productGenerated.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Image.file(
                            File(productGenerated[index].imageFile?.path ?? ""),
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleWithValueWidget(
                                title: "Name:",
                                value: productGenerated[index].name ?? ""),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleWithValueWidget(
                                title: "Description:",
                                value:
                                    productGenerated[index].description ?? ""),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleWithValueWidget(
                                title: "Price:",
                                value:
                                    productGenerated[index].price.toString()),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleWithValueWidget(
                                title: "Websites to buy:",
                                value: productGenerated[index]
                                        .website
                                        ?.join(", ") ??
                                    ""),
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          )),
          const SizedBox(height: 30),
          const Text("Select Product Image to Generate Details",
              style: TextStyle(fontSize: 24, color: Colors.white)),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: getImageFromGallery,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 250,
                height: 250,
                child: _imageFile == null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add_a_photo),
                      )
                    : Image.file(File(_imageFile?.path ?? ""),
                        fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleWithValueWidget extends StatelessWidget {
  const TitleWithValueWidget({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 5,
        ),
        Text(value,
            style: const TextStyle(
              fontSize: 16,
            )),
      ],
    );
  }
}
