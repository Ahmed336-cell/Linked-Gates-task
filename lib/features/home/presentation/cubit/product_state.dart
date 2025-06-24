import 'package:apitask/features/home/domain/entities/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductSuccess extends ProductState {
  final List<ProductEntity> products;

  ProductSuccess(this.products);
}
class ProductFailure extends ProductState {
  final String error;

  ProductFailure(this.error);
}