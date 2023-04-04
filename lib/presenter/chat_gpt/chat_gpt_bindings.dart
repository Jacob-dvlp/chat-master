import 'package:get/get.dart';
import './chat_gpt_controller.dart';

class ChatGptBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ChatGptController());
    }
}