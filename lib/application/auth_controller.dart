

import 'dart:ui';

import 'package:get/get.dart';
import 'package:setup_provider/domain/facade/auth_facade.dart';
import 'package:setup_provider/infastructura/servises/app_helper.dart';

class AuthController extends GetxController{
  final AuthFacade auth;

  bool isLoading = false;

  AuthController(this.auth);

  login(String email,String password,{VoidCallback? onSuccess}) async {
    isLoading = true;
    update();
    final res = await auth.login(email,password);
    res.fold((l) {
      onSuccess?.call();
    }, (r) {
      return AppHelper.errorSnackBar(message: r);
    });
    isLoading = false;
    update();
  }

}