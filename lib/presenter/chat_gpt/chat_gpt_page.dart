import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './chat_gpt_controller.dart';

class ChatGptPage extends GetView<ChatGptController> {
    
    const ChatGptPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('ChatGptPage'),),
            body: Container(),
        );
    }
}