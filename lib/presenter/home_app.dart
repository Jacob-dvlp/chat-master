import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_router.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRouter.route,
      initialRoute: "/",
    );
  }
}
