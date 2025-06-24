import 'package:apitask/core/error/failures.dart';
import 'package:apitask/features/home/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/product.dart';

class GetProducts {

  final ProductRepository productRepository;

  GetProducts(this.productRepository);
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await productRepository.getProducts();
  }
}