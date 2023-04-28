import 'package:get/get.dart';

import '../chat_gpt/chat_gpt_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashPageController extends GetxController {
  String key = "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";
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offNamed(ChatGptPage.routNamed);
      },
    );
     FlutterNativeSplash.remove();

    super.onInit();
  }
}
