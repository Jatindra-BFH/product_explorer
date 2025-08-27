import 'package:hive/hive.dart';

part 'product.g.dart'; // Required for code generation

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String? category;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final double? discountPercentage;

  @HiveField(6)
  final double? rating;

  @HiveField(7)
  final List<String>? tags;

  @HiveField(8)
  final String? warrantyInformation;

  @HiveField(9)
  final String? shippingInformation;

  @HiveField(10)
  final List<String>? images;

  @HiveField(11)
  final String? thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.category,
    this.discountPercentage,
    this.rating,
    this.tags,
    this.warrantyInformation,
    this.shippingInformation,
    this.images,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> product) {
    return Product(
      id: product['id'],
      title: product['title'],
      description: product['description'],
      price: (product['price'] as num).toDouble(),
      category: product['category'],
      discountPercentage: product['discountPercentage'] != null
          ? (product['discountPercentage'] as num).toDouble()
          : null,
      rating: product['rating'] != null
          ? (product['rating'] as num).toDouble()
          : null,
      tags: product['tags'] != null ? List<String>.from(product['tags']) : null,
      warrantyInformation: product['warrantyInformation'],
      shippingInformation: product['shippingInformation'],
      images: product['images'] != null ? List<String>.from(product['images']) : null,
      thumbnail: product['thumbnail'],
    );
  }
}
