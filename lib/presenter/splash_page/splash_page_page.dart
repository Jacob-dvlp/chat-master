import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_page_controller.dart';

class SplashPagePage extends GetView<SplashPageController> {
  const SplashPagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashPageController>(
        init: SplashPageController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset("asset/logo.png"),
              ),
            ),
          );
        });
  }
}
