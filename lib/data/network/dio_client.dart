import 'package:dio/dio.dart';

class DioClient {
  Dio get dio {
    final dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    return dio;
  }
}
