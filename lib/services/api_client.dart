import 'package:dio/dio.dart';
import 'package:hot_news/services/api_end_points.dart';

class ApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndPoints.baseUrl,
        connectTimeout: const Duration(milliseconds: 10000),
        receiveTimeout: const Duration(milliseconds: 10000),
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  // perform a GET request to the specified [path]
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameteres,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameteres,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print(
          'ApiClient DioError - Response Status: ${e.response!.statusCode}',
        );
        print('ApiClient DioError - Response Data: ${e.response!.data}');
        print('ApiClient DioError - Response Headers: ${e.response!.headers}');
      }

      print('ApiClient DioError - Message: ${e.message}');
      throw Exception('Netowork or API error: ${e.message}');
    } catch (e) {
      print('ApiClient Geberic Error: $e');
      throw Exception('An unexpected error occurred during the request: $e');
    }
  }
}
