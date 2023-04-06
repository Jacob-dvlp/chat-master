import 'package:get/get.dart';

import 'presenter/chat_gpt/chat_gpt_bindings.dart';
import 'presenter/chat_gpt/chat_gpt_page.dart';

class AppRouter {
  static final List<GetPage> route = [
    GetPage(
        name: ChatGptPage.routNamed,
        page: () => const ChatGptPage(),
        binding: ChatGptBindings()),
    GetPage(
        name: ChatGptPage.routNamed,
        page: () => const ChatGptPage(),
        binding: ChatGptBindings())
  ];
}
