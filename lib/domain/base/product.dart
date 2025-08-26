class Product {
  final int id;
  final String title;
  final String description;
  final String? category;
  final double price;
  final double? discountPercentage;
  final double? rating;
  final List<String>? tags;
  final String? warrantyInformation;
  final String? shippingInformation;
  final List<String>? images;
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
      discountPercentage: product['discountPercentage'] != null ? (product['discountPercentage'] as num).toDouble() : null,
      rating: product['rating'] != null ? (product['rating'] as num).toDouble() : null,
      tags: product['tags'] != null ? List<String>.from(product['tags']) : null,
      warrantyInformation: product['warrantyInformation'],
      shippingInformation: product['shippingInformation'],
      images: product['images'] != null ? List<String>.from(product['images']) : null,
      thumbnail: product['thumbnail'],
    );
  }
}
