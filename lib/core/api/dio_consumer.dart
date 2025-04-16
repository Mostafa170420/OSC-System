import 'package:dio/dio.dart';
import 'package:osc_system/core/api/api_consumer.dart';
import 'package:osc_system/core/api/end_point.dart';

class DioConsumer extends ApiConsumer {
  final dio = Dio();
  DioConsumer() {
    dio.options.baseUrl = EndPoint.baseUrl;
  }
  @override
  Future delete(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future patch(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future post(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      bool isFromData = false}) async {
    await dio.post(path, data: data);
  }
}
