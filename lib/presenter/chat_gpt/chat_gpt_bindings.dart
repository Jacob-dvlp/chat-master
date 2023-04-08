import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../src/repository/repository_chat.dart';
import 'chat_gpt_controller.dart';

class ChatGptBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Dio());
    Get.put(RepositoryChat(
      Get.find(),
    ));
    Get.put(ChatGptController(Get.find()));
  }
}
