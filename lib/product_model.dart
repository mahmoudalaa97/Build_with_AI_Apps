import 'package:image_picker/image_picker.dart';

class ProductModel {
  String? name;
  String? description;
  String? price;
  List<String>? website;
  XFile? imageFile;

  ProductModel(
      {this.name, this.description, this.price, this.imageFile, this.website});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['product_name'],
      description: json['description'],
      price: json['price'],
      website: List<String>.from(json['websites']),
    );
  }
}
