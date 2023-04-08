import 'package:get/get.dart';
import './key_generate_controller.dart';

class KeyGenerateBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(KeyGenerateController());
    }
}