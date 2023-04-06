import 'package:get/get.dart';

import '../chat_gpt/chat_gpt_page.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offNamed(ChatGptPage.routNamed);
      },
    );
    super.onInit();
  }
}
