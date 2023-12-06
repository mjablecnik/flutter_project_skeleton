import 'package:dio/dio.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:flutter_project_skeleton/core/singletons/getter.dart';

class HttpClient {
  late final Dio client;

  static final HttpClient get = HttpClient._initialize();

  HttpClient._initialize() {
    Get.logger.log('DeviceId: ${Get.cached.deviceId}');
    client = Dio(
      BaseOptions(
        baseUrl: Get.app.flavor.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        headers: {
          'Content-Type': 'application/json',
          'X-Terminal-Id': Get.cached.deviceId,
          'X-App-Code': '115',
        },
      ),
    );
    if (Get.app.flavor.logs.enableHttpLogs) {
      client.interceptors.add(
        TalkerDioLogger(
          settings: TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseHeaders: false,
            printResponseMessage: true,
            responseFilter: (Response response) {
              if (Get.app.flavor.logs.preventLargeResponses) {
                return response.data.toString().length <= 500;
              } else {
                return true;
              }
            },
          ),
        ),
      );
    }
  }

  Future<T> createRequest<T>(
      Future<Response> Function() request,
      Future<T> Function(dynamic data) parseData,
      ) async {
    try {
      final response = await request.call();
      if (response.statusCode == 200 && response.data != null) {
        try {
          return await parseData(response.data);
        } catch (error) {
          Get.logger.handle(error);
          throw ParseDataException();
        }
      }
      throw ServerException();
    } on DioException catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) throw InternetConnectionException();

      if (e.response?.statusCode == 403) {
        if (e.response?.data != null && e.response?.data!.containsKey('key')) {
          if (e.response?.data!['key'] == "Unknown terminal %s") {
            throw UnknownTerminalException();
          }
        }
        throw AccessDeniedException();
      } else {
        throw ServerException(
          message: "DioException response status code: ${e.response?.statusCode}",
        );
      }
    }
  }
}
