import 'category.dart';

class ProductEntity {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final CategoryEntity category;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });
}
