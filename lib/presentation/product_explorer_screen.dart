import 'package:flutter/material.dart';
import 'package:product_explorer/presentation/product_screen.dart';
import 'package:provider/provider.dart';

import '../domain/data_models/product.dart';
import '../provider/data_provider.dart';
import '../provider/layout_utilities_provider.dart';
import '../utilities/layout_type.dart';

class ProductExplorerScreen extends StatefulWidget {
  const ProductExplorerScreen({super.key});

  @override
  State<ProductExplorerScreen> createState() => _ProductExplorerScreenState();
}

class _ProductExplorerScreenState extends State<ProductExplorerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  Widget _buildProductGridItem(BuildContext context, Product product, LayoutUtilitiesProvider provider) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Expanded(
              child: product.thumbnail != null
                  ? Image.network(
                product.thumbnail!,
                fit: BoxFit.cover,
                width: double.infinity,
              )
                  : const Icon(Icons.image_not_supported),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              child: Text(
                product.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize : provider.textSize, fontFamily: provider.textStyle.fontFamily, fontStyle: provider.textStyle.fontStyle),
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListItem(BuildContext context, Product product, LayoutUtilitiesProvider provider) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductScreen(product: product),
          ),
        );
      },
      leading: product.thumbnail != null
          ? Image.network(
        product.thumbnail!,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      )
          : const Icon(Icons.image_not_supported, size: 60),
      title: Text(
        product.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize : provider.textSize, fontFamily: provider.textStyle.fontFamily, fontStyle: provider.textStyle.fontStyle),
      ),
      subtitle: Text(
        '\$${product.price.toStringAsFixed(2)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final layoutUtilitiesProvider = Provider.of<LayoutUtilitiesProvider>(context);
    final products = dataProvider.products;
    final filteredProducts = _searchQuery.isEmpty
        ? products
        : products
        .where((product) => product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row( 
              children: [
                Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                          : null,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ), 
                SizedBox(width: 20),
                IconButton(onPressed: (){
                  layoutUtilitiesProvider.layoutType==LayoutType.grid ? 
                  layoutUtilitiesProvider.setLayoutType(LayoutType.list)
                  : layoutUtilitiesProvider.setLayoutType(LayoutType.grid);
                }, 
                  icon: layoutUtilitiesProvider.layoutType==LayoutType.grid ? Icon(Icons.list):Icon(Icons.grid_on))
              ]
              ),
            
            const SizedBox(height: 10),

            Expanded(
              child: dataProvider.isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : filteredProducts.isEmpty
                  ? const Center(child: Text("No products found."))
                  : layoutUtilitiesProvider.layoutType == LayoutType.grid
                  ? GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: filteredProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: layoutUtilitiesProvider.gridSize,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return _buildProductGridItem(context, product, layoutUtilitiesProvider);
                },
              )
                  : ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: filteredProducts.length,
                separatorBuilder: (_, __) => const Divider(height: 10),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return _buildProductListItem(context, product, layoutUtilitiesProvider);
                },
              )

            ),
        ]
        ),
    );
  }
}
