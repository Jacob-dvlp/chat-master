// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_enum.dart';
import '../../src/model/model_chat.dart';
import '../../src/repository/repository_chat.dart';

class ChatGptController extends GetxController {
  final input = TextEditingController();
  final RepositoryChat repository;
  final List<ModelChat> msg = [];
  final scrollController = ScrollController();
  int duration = 200;
  bool isResponse = false;
  bool textScanner = false;
  String scannerText = "";
  String keyteste = "";
  XFile? img;

  ChatGptController(this.repository);

  scrollDown() {
    Future.delayed(
      Duration(milliseconds: duration),
      () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut);
      },
    );
  }

 

  progrssIndicator(bool value) {
    isResponse = value;
    update();
  }

  progrssIndicatorgetrecognisedText(bool value) {
    textScanner = value;
    update();
  }

  Future sendMsg({required String prompt}) async {
    progrssIndicator(true);
    String keyteste = "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";

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? key = sharedPreferences.getString("key");
    String responseMsg =
        await repository.getResponse(msg: prompt, key: keyteste);
    msg.add(
      ModelChat(
        message: responseMsg.trim(),
        messageFrom: MessageFrom.bot,
      ),
    );
    progrssIndicator(false);
    scrollDown();
    update();
  }

  Future getRecognisedText(XFile img) async {
    progrssIndicatorgetrecognisedText(true);
    final inputImage = InputImage.fromFilePath(img.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannerText = "";
    for (TextBlock textBlock in recognizedText.blocks) {
      for (TextLine line in textBlock.lines) {
        scannerText = "$scannerText${line.text}\n";
      }
    }
    if (scannerText.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        title: "Arquivo",
        titleText: Text("Erro ao fazer a leitura de caracterticas na imagen"),
      ));
    }
    progrssIndicatorgetrecognisedText(false);
    await sendMsg(prompt: scannerText);

    update();
  }

  // Future camera() async {
  //   try {
  //     final image =
  //         await ImagePicker.platform.getImage(source: ImageSource.camera);
  //     if (image != null) {
  //       img = image;
  //       getRecognisedText(img!);
  //       update();
  //     } else {
  //       Get.showSnackbar(
  //         const GetSnackBar(
  //           title: "Falha",
  //           titleText: Text("Erro ao fazer a leitura de Imagem"),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     textScanner = false;
  //   }
  // }

  Future getImage() async {
    try {
      final image =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
      
      if (image != null) {
        img = image;
        getRecognisedText(img!);
        update();
      } else if (img == null) {
        return Get.showSnackbar(const GetSnackBar(
          titleText: Text("Falha"),
          messageText: Text(
            "Erro ao fazer a leitura de Imagem",
          ),
          backgroundColor: Colors.white,
          duration: Duration(seconds: 4),
        ));
      }
    } catch (e) {
      textScanner = false;
      return;
    }
  }
}
