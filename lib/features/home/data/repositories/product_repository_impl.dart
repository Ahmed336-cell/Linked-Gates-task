import 'package:apitask/core/error/failures.dart';
import 'package:apitask/features/home/data/model/product_model.dart';
import 'package:apitask/features/home/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasoruce/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final productModel = await productRemoteDataSource.fetchProducts();
      return Right(productModel);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure('An unexpected error occurred. Please try again.'));
    }
  }
}