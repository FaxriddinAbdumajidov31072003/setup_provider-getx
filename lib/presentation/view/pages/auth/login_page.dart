import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:setup_provider/application/auth_controller.dart';
import 'package:setup_provider/domain/di/di.dart';
import 'package:setup_provider/infastructura/servises/app_validators.dart';
import 'package:setup_provider/presentation/components/custom_button.dart';
import 'package:setup_provider/presentation/components/custom_text_form_field.dart';
import 'package:setup_provider/presentation/view/pages/main/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.put(AuthController(authRepo));
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
   TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Login Page",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextFormField(
                controller: emailController,
                validator: (s) {
                  if (AppValidators.isValidEmail(s ?? "")) {
                    return null;
                  } else {
                    return "Email Xatto";
                  }
                },
                label: "Login",
              ),
              24.verticalSpace,
              CustomTextFormField(
                controller: passwordController,
                validator: (s) {
                  if (AppValidators.isValidPassword(s ?? "")) {
                    return null;
                  } else {
                    return "password is incorrect";
                  }
                },
                label: "Password",
              ),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false) {
                        authController.login(
                          emailController.text,
                          passwordController.text,
                           onSuccess: () {
                          Get.to(() => const MainPage());
                        });
                      }
                    },
                    title: "Login",
                    isLoading: controller.isLoading,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
