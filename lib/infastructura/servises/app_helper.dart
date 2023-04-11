
import 'package:get/get.dart';

abstract class AppHelper {
  AppHelper._();

  static errorDialog(String message) {
    return Get.defaultDialog(title: message);
  }

  static errorSnackBar({required String message}) {
    Get.snackbar("Error", message);
  }
}
