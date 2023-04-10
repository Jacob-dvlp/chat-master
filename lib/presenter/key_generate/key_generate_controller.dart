import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyGenerateController extends GetxController {
  final controller = TextEditingController();
  Future saveKey() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (controller.text.isEmpty) {
      return Get.snackbar(
        "Falha",
        "Campo vazio não é permetido",
        backgroundColor: Colors.red,
        colorText: Colors.white,
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
}
