import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiClient {
  Future<Response> get(
      String endpoint,
      ) async {
    return await DioClient.dio.get(endpoint);
  }
}