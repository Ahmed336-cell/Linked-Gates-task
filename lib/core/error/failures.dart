import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with Api Server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout with Api Server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout with Api Server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request to API server was canceled");
      case DioExceptionType.unknown:
        if (dioException.message?.contains("SocketException") ?? false) {
          return ServerFailure("No Internet Connection");
        }
        return ServerFailure("Unexpected error, please try again later");
      default:
        return ServerFailure("Oops, there was an error, please try again");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure("Your request not found, please try again later");
    } else if (statusCode == 500) {
      return ServerFailure("Internal server error, please try again later");
    } else {
      return ServerFailure("Oops, there was an error, please try again");
    }
  }
}