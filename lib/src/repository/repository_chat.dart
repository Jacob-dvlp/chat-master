import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/app_config.dart';
import '../../core/app_url.dart';

class RepositoryChat {
  final Dio _dio;
  RepositoryChat(this._dio);

  Future getResponse({required String msg, required String key}) async {
        String? msg;

    try {

      Map<String, dynamic> data = {
        "model": "text-davinci-003",
        "prompt": msg,
        "temperature": 0,
        "max_tokens": 1000,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
      };

      Response response = await _dio.post(
        url,
        data: data,
        options: Options(headers: {"Authorization": "Bearer ${AppConfig.key}"}),
      );
      if (response.statusCode == 200) {
        msg = response.data["choices"][0]["text"];
      }

      return msg!.trim();
    } catch (e) {
      log(e.toString(), name: "Erro");
      return "Ocorreu um erro!";
    }
  }
}
