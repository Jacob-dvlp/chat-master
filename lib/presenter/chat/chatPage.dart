import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/appThema.dart';
import '../../core/app_enum.dart';
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

  screollDown() {
    Future.delayed(
      Duration(milliseconds: duration),
      () {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut);
      },
    );
  }

  sendMsg() async {
    if (input.text.isNotEmpty) {
      String prompt = input.text.trim();
      setState(() {
        msg.add(
          ModelChat(
            message: prompt,
            messageFrom: MessageFrom.me,
          ),
        );
        input.clear();
        screollDown();
      });

      String responseMsg = await repository.getResponse(msg: prompt);
      setState(() {
        msg.add(
          ModelChat(
            message: responseMsg.trim(),
            messageFrom: MessageFrom.bot,
          ),
        );

        screollDown();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppThema.primaryColor,
        appBar: AppBar(
          backgroundColor: AppThema.primaryColor,
          title: const Text('C h a t M a s t e r'),
          centerTitle: true,
        ),
        body: SizedBox.expand(
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
                          if (msg[index].messageFrom == MessageFrom.me)
                            const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(12),
                            //  height: MediaQuery.of(context).size.height/3,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(12),
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
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                TextField(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  maxLines: 4,
                  minLines: 1,
                  controller: input,
                  decoration: InputDecoration(
                      hintText: "Qual é a tua duvida...",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppThema.secondaryColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: AppThema.secondaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppThema.secondaryColor),
                      ),
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: () {
                          sendMsg();
                        },
                        icon: const Icon(Icons.send),
                      )),
                ),
              ],
            ),
          ),
        ));
  }
}
