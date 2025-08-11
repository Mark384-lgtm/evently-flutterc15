import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/ThemeProvider.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/resources/StringsManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppElevatedButton.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppTextFormField.dart';
import 'package:evently_c15_flutter/core/reusable_components/DialogeUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/Constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static String routeName = "Forget Password Screen";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode current_them = Provider.of<ThemeProvider>(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringsManager.forgetPassword.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: current_them == ThemeMode.dark
                ? Theme.of(context).colorScheme.primary
                : Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: current_them == ThemeMode.dark
              ? Theme.of(context).colorScheme.primary
              : Colors.black,
        ),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  width: double.infinity,
                  AssetsMnager.ForgetPassword,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Column(
                children: [
                  AppElevatedButton(
                    text: StringsManager.ResetPassword,
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        restPassword();
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  AppTextFormField(
                    validationAlgorithm: checkMailValidation,
                    controller: controller,
                    prefixIcon: Icons.mail,
                    hint: StringsManager.email,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? checkMailValidation(String? value) {
    if (value!.isEmpty) {
      return StringsManager.requiredFiled.tr();
    }
    return null;
  }

  void restPassword() async {
    DialogUtils.showloadingDialoge(context);
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: controller.text.trim(),
    );
    Navigator.pop(context);
    DialogUtils.showmessegeDialoge(context, StringsManager.checkUrMail.tr());
  }
}
