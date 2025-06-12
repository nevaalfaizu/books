import 'package:books/varglobal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: Global.srvBase,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: kIsWeb ? Duration.zero : const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    ),
  );
}
