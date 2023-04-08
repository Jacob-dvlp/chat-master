import 'package:get/get.dart';

import 'presenter/chat_gpt/chat_gpt_bindings.dart';
import 'presenter/chat_gpt/chat_gpt_page.dart';
import 'presenter/key_generate/key_generate_bindings.dart';
import 'presenter/key_generate/key_generate_page.dart';
import 'presenter/splash_page/splash_page_bindings.dart';
import 'presenter/splash_page/splash_page_page.dart';

class AppRouter {
  static final List<GetPage> route = [
    GetPage(
        name: SplashPagePage.routNamed,
        page: () => const SplashPagePage(),
        binding: SplashPageBindings()),
    GetPage(
        name: ChatGptPage.routNamed,
        page: () => const ChatGptPage(),
        binding: ChatGptBindings()),
    GetPage(
        name: KeyGeneratePage.routNamed,
        page: () => const KeyGeneratePage(),
        binding: KeyGenerateBindings())
  ];
}
