import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:project_model/core/networking_service/api/api_interceptors.dart';
import 'package:project_model/core/networking_service/api/portici_api/env.dart';
import 'package:tuple/tuple.dart';

class ApiPorticiService {
  // inizialization

  final String _baseUrl =
      'https://api-$porticiApiWorkEnvironmentName.smartpa.cloud/portico';

  final Dio _dio = Dio()
    ..interceptors.add(ApiInterceptors.apiPorticiInterceptors);

  Dio get dio => _dio;
  // end inizialization

  final Options _options =
      Options(headers: {'AuthorityId': porticiApiAuthorityId});

  Future<Tuple2<int?, String?>> getWarnings(
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get<dynamic>(
        '$_baseUrl/v1/warnings',
        queryParameters: queryParameters,
        options: _options,
      );

      return Tuple2<int?, String?>(
          response.statusCode, response.data.toString());
    } on DioError catch (e) {
      log('ERRORE GET TRANSACTION : ' + e.response!.statusCode!.toString());
      return Tuple2<int?, String?>(e.response!.statusCode!, null);
    }
  }
}
