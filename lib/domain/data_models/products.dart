import 'package:hive/hive.dart';
import 'package:product_explorer/domain/data_models/product.dart';
part 'products.g.dart';
@HiveType(typeId: 1)
class Products extends HiveObject{
  @HiveField(0)
  final List<Product> products;
  Products(this.products);
  
}
