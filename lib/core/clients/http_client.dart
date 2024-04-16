import 'package:dio/dio.dart';
import 'package:flutter_project_skeleton/core/app/exceptions.dart';
import 'package:flutter_project_skeleton/core/app/global.dart';
import 'package:flutter_project_skeleton/core/app/cached_data.dart';
import 'package:flutter_project_skeleton/core/app/logger.dart';
import 'package:flutter_project_skeleton/settings.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class HttpClient {
  late final Dio dio;

  HttpClient({
    required CachedData cached,
    required Settings settings,
  }) {
    //logger.log('DeviceId: ${cached.deviceId}');
    dio = Dio(
      BaseOptions(
        baseUrl: settings.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    if (settings.logs.enableHttpLogs) {
      dio.interceptors.add(
        TalkerDioLogger(
          talker: logger,
          settings: TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printRequestData: true,
            printResponseHeaders: false,
            printResponseMessage: true,
            responseFilter: (Response response) {
              if (settings.logs.preventLargeResponses) {
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
    Future<T> Function(dynamic data) parseData, {
    Future<ServerException?> Function(int? status, dynamic data)? onServerError,
  }) async {
    try {
      final response = await request.call();
      if (response.statusCode == 200 && response.data != null) {
        try {
          return await parseData(response.data);
        } on Error catch (error) {
          logger.error(error);
          logger.handle(error.stackTrace.toString());
          throw ParseDataException();
        }
      }
      throw ServerException();
    } on DioException catch (e) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) throw InternetConnectionException();

      if (e.response?.statusCode == 403) {
        throw AccessDeniedException();
      } else {
        if (onServerError != null && e.response != null) {
          try {
            final error = await onServerError.call(e.response?.statusCode, e.response?.data);
            if (error != null) throw error;
          } on Error catch (error) {
            logger.error(error);
            logger.handle(error.stackTrace.toString());
          }
        }
        throw ServerException(
          message: "DioException response status code: ${e.response?.statusCode}",
        );
      }
    }
  }
}
