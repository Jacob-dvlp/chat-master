import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_enum.dart';
import '../../core/app_thema.dart';
import '../key_generate/key_generate_page.dart';
import 'chat_gpt_controller.dart';

class ChatGptPage extends GetView<ChatGptController> {
  const ChatGptPage({Key? key}) : super(key: key);
  static String routNamed = "/chat";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatGptController>(
      init: ChatGptController(
        Get.find(),
      ),
      builder: (context) {
        return Scaffold(
          drawer: controller.key == ""
              ? Drawer(
                  shadowColor: Colors.white,
                  child: Container(
                    color: AppThema.secondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        InkWell(
                          onTap: () async {
                            Get.toNamed(KeyGeneratePage.routNamed);
                          },
                          child: const ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.key_outlined,
                                  color: Colors.black,
                                )),
                            title: Text(
                              "Inserir a Key(GPT)",
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
          backgroundColor:
              controller.msg.isEmpty ? Colors.black : AppThema.primaryColor,
          appBar: AppBar(
            backgroundColor:
                controller.msg.isEmpty ? Colors.black : AppThema.primaryColor,
            title: const Text(
              'Reconhecedor de Texto/ChatGPT',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    controller.msg.clear();
                    controller.update();
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ))
            ],
            centerTitle: true,
          ),
          floatingActionButton: controller.textScanner
              ? CircularProgressIndicator(
                  color: AppThema.secondaryColor,
                  backgroundColor: Colors.white,
                )
              : FloatingActionButton(
                  onPressed: () {
                    controller.getImage();
                  },
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.photo_rounded,
                    color: AppThema.secondaryColor,
                  ),
                ),
          body: controller.msg.isEmpty
              ? Center(
                  child: controller.isResponse
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
                            controller: controller.scrollController,
                            itemCount: controller.msg.length,
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
                                    width: controller.msg[index].messageFrom ==
                                            MessageFrom.me
                                        ? MediaQuery.of(context).size.width /
                                            2.5
                                        : MediaQuery.of(context).size.width *
                                            0.7,
                                    padding:
                                        controller.msg[index].messageFrom ==
                                                MessageFrom.me
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
                                      controller.msg[index].message,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        controller.isResponse
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
                ),
        );
      },
    );
  }
}
