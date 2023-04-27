import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class KeyGenerateController extends GetxController {
  final controller = TextEditingController(text: "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");
  Future saveKey() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (controller.text.isEmpty) {
      return Get.snackbar(
        "Falha",
        "Campo vazio não é permetido",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    }
    sharedPreferences.setString("key", controller.text);
    return Get.snackbar("Sucesso", "A tua key foi salvo com sucesso",
        backgroundColor: Colors.green);
  }

  clipPaste({required String value}) {
    controller.text = value;
    update();
  }
    openUrllaunchUrl() async {
    if (await launchUrl(
      Uri.parse('https://platform.openai.com/account/api-keys'),
    )) {
      debugPrint('succesfully');
    }
  }
}
