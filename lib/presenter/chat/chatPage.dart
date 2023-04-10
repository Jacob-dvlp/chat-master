import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_enum.dart';
import '../../core/app_thema.dart';
import '../../src/model/model_chat.dart';
import '../../src/repository/repository_chat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final input = TextEditingController();
  final repository = RepositoryChat(Dio());
  final List<ModelChat> msg = [];
  final scrollController = ScrollController();
  int duration = 200;
  bool isResponse = false;
  bool textScanner = false;
  String scannerText = "";
  String key = "";
  XFile? img;

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
    setState(() {
      isResponse = value;
    });
  }

  progrssIndicatorgetrecognisedText(bool value) {
    setState(() {
      textScanner = value;
    });
  }

  Future sendMsg({required String prompt}) async {
    progrssIndicator(true);
    String responseMsg = await repository.getResponse(msg: prompt, key: "");
    setState(() {
      msg.add(
        ModelChat(
          message: responseMsg.trim(),
          messageFrom: MessageFrom.bot,
        ),
      );
      progrssIndicator(false);
      scrollDown();
    });
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
    progrssIndicatorgetrecognisedText(false);
    await sendMsg(prompt: scannerText);
    setState(() {});
  }

  Future camera() async {
    try {
      final image =
          await ImagePicker.platform.getImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          img = image;
          getRecognisedText(img!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erro ao fazer a leitura de Imagem"),
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
        setState(() {
          img = image;
          getRecognisedText(img!);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erro ao fazer a leitura de Imagem"),
          ),
        );
      }
    } catch (e) {
      textScanner = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: key == ""
            ? Drawer(
                shadowColor: Colors.white,
                child: Container(
                  color: AppThema.secondaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      InkWell(
                        onTap: () async {
                          if (await launchUrl(
                            Uri.parse(
                                'https://platform.openai.com/account/api-keys'),
                          )) {
                            debugPrint('succesfully');
                          }
                        },
                        child: const ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.link_rounded,
                                color: Colors.black,
                              )),
                          title: Text(
                            "Pegar a chave",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          //  controller.openUrllaunchUrl();
                        },
                        child: const ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.paste,
                                color: Colors.black,
                              )),
                          title: Text(
                            "Colar a Key",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
        backgroundColor: msg.isEmpty ? Colors.black : AppThema.primaryColor,
        appBar: AppBar(
          backgroundColor: msg.isEmpty ? Colors.black : AppThema.primaryColor,
          title: const Text(
            'Chat Inteligente / GPT',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  msg.clear();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.delete_outline,
                ))
          ],
          centerTitle: true,
        ),
        floatingActionButton: textScanner
            ? CircularProgressIndicator(
                color: AppThema.secondaryColor,
                backgroundColor: Colors.white,
              )
            : FloatingActionButton(
                onPressed: () {
                  getImage();
                },
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.photo_rounded,
                  color: AppThema.secondaryColor,
                ),
              ),
        body: msg.isEmpty
            ? Center(
                child: isResponse
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.black,
                      )
                    : Image.asset("asset/logo.png"))
            : SizedBox.expand(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: msg.length,
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  // backgroundColor: Colors.grey[200],
                                  child: Image.asset("asset/logo.png"),
                                ),
                                Container(
                                    margin: const EdgeInsets.all(12),
                                    width: msg[index].messageFrom ==
                                            MessageFrom.me
                                        ? MediaQuery.of(context).size.width /
                                            2.5
                                        : MediaQuery.of(context).size.width *
                                            0.7,
                                    padding:
                                        msg[index].messageFrom == MessageFrom.me
                                            ? const EdgeInsets.only(
                                                left: 5,
                                                top: 12,
                                                right: 5,
                                                bottom: 12)
                                            : const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppThema.secondaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      msg[index].message,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    )),
                              ],
                            );
                          },
                        ),
                      ),
                      isResponse
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LinearProgressIndicator(
                                backgroundColor: AppThema.secondaryColor,
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ));
  }
}
