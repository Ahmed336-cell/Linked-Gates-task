import 'package:apitask/core/utils/constants.dart';
import 'package:dio/dio.dart';
class ApiService{
  final _baseUrl = Constant.baseUrl;
  final Dio _dio;
  ApiService(this._dio);

  Future<dynamic> get({required String endpoint}) async{
    var response= await _dio.get("$_baseUrl$endpoint");
    return response.data;
  }
}