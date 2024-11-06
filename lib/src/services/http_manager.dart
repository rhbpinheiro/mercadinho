import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class HttpMethods {
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String get = 'GET';
  static const String delete = 'DELETE';
  static const String patch = 'PATCH';
}

class HttpManager {
  Future restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {
    final dio = Dio();

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': dotenv.env['PARSE_APPLICATION_ID'] ?? '',
        'X-Parse-REST-API-Key': dotenv.env['PARSE_REST_API_KEY'] ?? '',
      });

    try {
      Response response = await dio.request(
        url,
        options: Options(
          headers: defaultHeaders,
          method: method,
        ),
        data: body,
      );
      return response.data;
    } on DioException catch (error) {
      return error.response?.data ?? {};
    } catch (error) {
      return {};
    }
  }
}
