import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
        duration: const Duration(seconds: 4),
      );
    }
    if (controller.text.length == 51) {
      await sharedPreferences.setString("key", controller.text);
      return Get.showSnackbar(
        const GetSnackBar(
            titleText: Text("Sucesso"),
            messageText: Text(
              "A tua key foi salvo com sucesso",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            duration: Duration(seconds: 4),
            icon: Icon(Icons.check),
            backgroundColor: Colors.black),
      );
    } else if (controller.text.contains(" ")) {
      return Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Inválido",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 4),
          messageText: Text(
            "O tipo de Key inserido é inválido",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          backgroundColor: Colors.red));
    } else {
      return Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Inválido",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          duration: Duration(seconds: 4),
          messageText: Text(
            "O tipo de Key inserido é inválido",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          backgroundColor: Colors.red));
    }
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
