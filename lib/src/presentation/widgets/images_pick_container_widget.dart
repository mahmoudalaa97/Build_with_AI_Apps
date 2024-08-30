import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ImagesPickContainer extends StatelessWidget {
  final void Function(int? index) onImageSelected;
  final void Function(int index)? onImageRemoved;
  final List<XFile?>? imageFiles;
  const ImagesPickContainer(
      {super.key,
      required this.onImageSelected,
      required this.onImageRemoved,
      required this.imageFiles});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload an image:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: screenSize.width,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              ...imageFiles?.map((imageFile) {
                    return GestureDetector(
                      onTap: () {
                        onImageSelected(imageFiles!.indexOf(imageFile));
                      },
                      onLongPress: () {
                        if (onImageRemoved != null) {
                          onImageRemoved!(imageFiles!.indexOf(imageFile));
                        }
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: imageFile?.path.isNotEmpty == true
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imageFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(Icons.photo),
                      ),
                    );
                  }).toList() ??
                  [],
              if ((imageFiles?.length ?? 0) < 5)
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      onImageSelected(null);
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
