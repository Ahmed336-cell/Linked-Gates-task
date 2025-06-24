import 'dart:convert';

import 'package:apitask/core/network/api_service.dart';
import 'package:apitask/core/utils/constants.dart';
import 'package:apitask/features/home/data/model/product_model.dart';

class ProductRemoteDataSource{
  final ApiService apiService;

  ProductRemoteDataSource(this.apiService);
  Future<List<ProductModel>> fetchProducts() async {
    final response = await apiService.get(endpoint: Constant.endpoint);
    final List data = response as List<dynamic>;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}