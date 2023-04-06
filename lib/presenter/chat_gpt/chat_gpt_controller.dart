// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String key = "";
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

  openUrllaunchUrl() async {
    if (await launchUrl(
      Uri.parse('https://platform.openai.com/account/api-keys'),
    )) {
      debugPrint('succesfully');
    }
  }

  Future sendMsg({required String prompt}) async {
    progrssIndicator(true);
    String responseMsg = await repository.getResponse(msg: prompt);

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

  Future camera() async {
    try {
      final image =
          await ImagePicker.platform.getImage(source: ImageSource.camera);
      if (image != null) {
        img = image;
        getRecognisedText(img!);
        update();
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Falha",
            titleText: Text("Erro ao fazer a leitura de Imagem"),
          ),
        );
      }
    } catch (e) {
      textScanner = false;
    }
  }

  Future getImage() async {
    try {
      final image =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);
      if (image != null) {
        img = image;
        getRecognisedText(img!);
        update();
      } else {
        Get.showSnackbar(const GetSnackBar(
          title: "Falha",
          titleText: Text("Erro ao fazer a leitura de Imagem"),
        ));
      }
    } catch (e) {
      textScanner = false;
    }
  }
}
