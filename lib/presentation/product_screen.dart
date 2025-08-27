import 'package:flutter/material.dart';
import 'package:product_explorer/domain/data_models/product.dart';
import 'package:product_explorer/provider/layout_utilities_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final layoutUtilitiesProvider = Provider.of<LayoutUtilitiesProvider>(context);
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 241, 253),
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  if (product.thumbnail != null)
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.network(
                        product.thumbnail!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),

                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (product.discountPercentage != null)
                          Text(
                            "${product.discountPercentage!.toStringAsFixed(1)}% OFF",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                  ),
                  const SizedBox(height: 8),

                  if (product.rating != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        IconData icon;
                        Color color;
                        double rating = product.rating!;
                        if (index + 1 <= rating) {
                          icon = Icons.star;
                          color = Colors.orange[400]!;
                        } else if (index + 0.5 <= rating) {
                          icon = Icons.star_half;
                          color = Colors.orange[400]!;
                        } else {
                          icon = Icons.star_border;
                          color = Colors.grey;
                        }

                        return Icon(icon, color: color, size: 20);
                      }),
                    ),

                ],
              ),
            ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: layoutUtilitiesProvider.textSize, fontFamily: layoutUtilitiesProvider.textStyle.fontFamily),
                  ),
                  const SizedBox(height: 24),

                  if (product.category != null) ...[
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 18, fontFamily: layoutUtilitiesProvider.textStyle.fontFamily, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.category!,
                      style: TextStyle(fontSize: layoutUtilitiesProvider.textSize, fontFamily: layoutUtilitiesProvider.textStyle.fontFamily, fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                  ],

                  if (product.tags != null && product.tags!.isNotEmpty) ...[
                    Text(
                      "Tags",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: product.tags!
                          .map(
                            (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey[200],
                        ),
                      )
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  if (product.warrantyInformation != null || product.shippingInformation != null) ...[
                    Text(
                      "Information",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.warrantyInformation != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Warranty: ${product.warrantyInformation!}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            if (product.shippingInformation != null)
                              Text(
                                "Shipping: ${product.shippingInformation!}",
                                style: const TextStyle(fontSize: 16),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (product.images != null && product.images!.isNotEmpty)
              Text(
                "Images",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (product.images != null && product.images!.isNotEmpty)
              Center(
                child:SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: product.images!.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(product.images![index], width: 200, height: 200, fit: BoxFit.cover),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                ),
              )
              ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}