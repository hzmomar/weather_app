import 'dart:io';

import 'package:dio/dio.dart';
import 'package:teleport_air_asia/core/model/exception/error_model.dart';
import 'package:teleport_air_asia/core/model/exception/failure_exception.dart';
import 'package:teleport_air_asia/core/model/flavor_manager.dart';
import 'base_url.dart';

class Api {
  late Dio dio;

  Api() {
    dio = Dio();
    dio.options
      ..headers = {}
      ..responseType = ResponseType.json;
    // add alice Http inspector tool and disable it when production
    if (!FlavorManager.instance.isProd) {
      // shake to view inspector tool
      // final Alice alice = Alice(
      //   darkTheme: true,
      //   navigatorKey: navigationService.navigationKey,
      //   showInspectorOnShake: true,
      //   showNotification: false,
      // );
      // dio.interceptors.add(alice.getDioInterceptor());
    }
  }

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParam}) async {
    try {
      dio.options.baseUrl = getBaseUrl();
      // add api key
      if(queryParam != null){
        queryParam['appid'] = FlavorManager.instance.settings.apiKey;
      }
      final Response response =
          await dio.get(endpoint, queryParameters: queryParam);
      return await checkStatus(response);
    } catch (e) {
      throw e;
    }
  }

  Future<Map<String, dynamic>> checkStatus(Response response) async {
    if (response.statusCode != HttpStatus.ok) {
      throw FailureException(ErrorModel.fromJson(response.data));
    } else {
      return response.data;
    }
  }
}
