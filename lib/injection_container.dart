import 'package:apitask/core/network/api_service.dart';
import 'package:apitask/features/home/data/datasoruce/product_remote_datasource.dart';
import 'package:apitask/features/home/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/home/data/repositories/product_repository_impl.dart';
import 'features/home/domain/usecases/get_products.dart';
import 'features/home/presentation/cubit/product_cubit.dart';

final sl = GetIt.instance;

Future<void>init()async{
  //cubit
  sl.registerFactory(()=> ProductCubit(sl()));

  //usecase
  sl.registerLazySingleton(() => GetProducts(sl()));

  //repository
  sl.registerLazySingleton<ProductRepository
  >(() => ProductRepositoryImpl(sl()));

  //data source
  sl.registerLazySingleton(() => ProductRemoteDataSource(sl()));

  //core
  sl.registerLazySingleton(() => ApiService(sl()));
  sl.registerLazySingleton(() => Dio());
}