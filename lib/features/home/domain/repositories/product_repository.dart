import 'package:apitask/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}