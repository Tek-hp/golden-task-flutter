import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';

// final apiServiceProvider = Provider<ApiService>((_) => ApiService());

class ApiService {
  final int connectionTimeout = 10 * 1000; // 10 seconds

  Dio get _dio => Dio(
        BaseOptions(
          baseUrl: "https://www.goldapi.io/api/",
          connectTimeout: connectionTimeout, //10 seconds
          headers: {
            "x-access-token": "goldapi-3spkzrrlg1x4wjf-io",
            "Content-Type": "application/json",
          },
        ),
      );

  getData(String url,
      {bool handleFeedback = true, Map<String, dynamic>? header}) async {
    CancelToken cancelToken = CancelToken();

    try {
      Response response = await _dio.get(
        url,
        cancelToken: cancelToken,
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        return DataResponse(
            success: true,
            data: response.data,
            statusCode: response.statusCode!);
      }
    } on DioError catch (e) {
      showToast("${e.response?.statusCode}");
      cancelToken.cancel();
      return await handleError(e, handleFeedback);
    }
  }

  handleError(DioError error, bool handleFeedback) async {
    log(error.response.toString());
    log(error.response?.statusCode.toString() ?? "status code = null ");
    if (error.response == null) {
      showToast('Make sure you are connected to internet',
          duration: const Duration(seconds: 2));
      return DataResponse(success: false, data: {}, statusCode: 0);
    }
    if (error.error.toString().contains("ailed host lookup")) {
      if (handleFeedback) {
        showToast("Check your Internet");
      }

      return DataResponse(success: false, data: {}, statusCode: 0);
    } else {
      if (error.type == DioErrorType.connectTimeout) {
        showToast(
          'Connection Timeout',
        );
      } else if (error.response!.statusCode! >= 300 &&
          error.response!.statusCode! <= 399) {
        if (handleFeedback) {
          showToast('Unknown Error\n${error.response!.data['message']}');
        }
      } else if (error.response!.statusCode == 422) {
        if (handleFeedback) {
          showToast(
              'Bad Request\n${error.response!.data['message'].map((e) => e['msg'])}');
        }
      } else if (error.response!.statusCode! >= 400 &&
          error.response!.statusCode! <= 499) {
        if (handleFeedback) {
          showToast('Bad Request\n${error.response!.data?['message']}');
        }
      } else if (error.response!.statusCode! >= 500 &&
          error.response!.statusCode! <= 599) {
        if (handleFeedback) {
          showToast('Service Unavailable\n${error.response!.data['message']}');
        }
      }
    }

    return DataResponse(
      data: {},
      success: false,
      statusCode: error.response?.statusCode ?? 0,
    );
  }
}

class DataResponse {
  late final dynamic data;
  late final bool success;
  late final int statusCode;

  DataResponse(
      {required this.data, required this.success, required this.statusCode});

  DataResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = data;
    data['success'] = success;
    data['status_code'] = statusCode;
    return data;
  }
}
