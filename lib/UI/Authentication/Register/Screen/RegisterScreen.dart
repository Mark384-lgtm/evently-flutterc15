import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/ThemeProvider.dart';
import 'package:evently_c15_flutter/UI/Home/Screen/HomeScreen.dart';
import 'package:evently_c15_flutter/core/remote/network/FireStoreManger.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppElevatedButton.dart';
import 'package:evently_c15_flutter/core/reusable_components/DialogeUtils.dart';
import 'package:evently_c15_flutter/core/reusable_components/Switches/LocalizationAppSwitch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/Constants.dart';
import '../../../../core/resources/StringsManger.dart';
import '../../../../core/reusable_components/AppTextFormField.dart';
import 'package:evently_c15_flutter/model/User.dart' as MyUser;
import '../../../../core/reusable_components/DialogeUtils.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = "Register Screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool isValidState;
  late TextEditingController userName_controller;
  late TextEditingController email_controller;
  late TextEditingController password_controller;
  late TextEditingController Repassword_controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bool isValidState = false;
    userName_controller = TextEditingController();
    email_controller = TextEditingController();
    password_controller = TextEditingController();
    Repassword_controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    userName_controller.dispose();
    email_controller.dispose();
    password_controller.dispose();
    Repassword_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode current_theme = Provider.of<ThemeProvider>(context).themeMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringsManager.forgetPassword.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: current_theme == ThemeMode.dark
                ? Theme.of(context).colorScheme.primary
                : Colors.black,
          ),
        ),

        iconTheme: IconThemeData(
          color: current_theme == ThemeMode.dark
              ? Theme.of(context).colorScheme.primary
              : Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Image.asset(AssetsMnager.logo),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextFormField(
                controller: userName_controller,
                validationAlgorithm: (value) => null,
                prefixIcon: Icons.person,
                hint: StringsManager.Name,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextFormField(
                controller: email_controller,
                validationAlgorithm: checkMailValidation,
                prefixIcon: Icons.mail,
                hint: StringsManager.email,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextFormField(
                controller: password_controller,
                validationAlgorithm: checkPassordValidation,
                hint: StringsManager.password,
                prefixIcon: Icons.lock,
                isPasswordField: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppTextFormField(
                controller: Repassword_controller,
                validationAlgorithm: checkRePassordValidation,
                hint: StringsManager.RePassword,
                prefixIcon: Icons.lock,
                isPasswordField: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              AppElevatedButton(
                text: StringsManager.create_account,
                onPress: () async {
                  isValidState = formKey.currentState!.validate();

                  if (isValidState) {
                    createAccount();
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringsManager.AlreayHaveAcconut.tr() + "?".tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      StringsManager.Login.tr(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,

                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              LocalizationAppSwitch(onLanguageChange: onChangeLanguage),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  String? checkMailValidation(String? value) {
    if (RegExp(Constants.e_mailRegex).hasMatch(value!)) {
      return null;
    }
    return tr(StringsManager.email_errorMessage);
  }

  String? checkPassordValidation(String? value) {
    if (value!.length >= 6) {
      return null;
    }
    return StringsManager.password_errorMessage.tr();
  }

  String? checkRePassordValidation(String? value) {
    if (password_controller.text.isEmpty)
      return StringsManager.requiredFiled.tr();

    if (value != password_controller.text) return "Password doesn't match";

    return null;
  }

  createAccount() async {
    try {
      DialogUtils.showloadingDialoge(context);
      var credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email_controller.text.trim(),
            password: password_controller.text,
          );
      await FireStoreManger.saveUser(
        MyUser.User(
          id: credentials.user?.uid,
          name: userName_controller.text,
          email: email_controller.text.trim(),
        ),
      );
      Navigator.pop(context);
      DialogUtils.showmessegeDialoge(
        context,
        StringsManager.addedSucessfully.tr(),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
      print(credentials.user?.uid);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        DialogUtils.showmessegeDialoge(
          context,
          StringsManager.weak_password.tr(),
        );
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showmessegeDialoge(
          context,
          StringsManager.already_exists.tr(),
        );
      } else {
        DialogUtils.showmessegeDialoge(context, e.toString());
      }
    } catch (e) {
      Navigator.pop(context);
      DialogUtils.showmessegeDialoge(context, e.toString());
    }
  }

  void onChangeLanguage() {
    if (!isValidState) {
      formKey.currentState?.validate();
    }
  }
}
