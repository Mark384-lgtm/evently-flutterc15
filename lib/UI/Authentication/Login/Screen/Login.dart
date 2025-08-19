import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/UI/Authentication/ForgetPassword/Screen/ForgetPasswordScreen.dart';
import 'package:evently_c15_flutter/UI/Authentication/Register/Screen/RegisterScreen.dart';
import 'package:evently_c15_flutter/UI/Home/Screen/HomeScreen.dart';
import 'package:evently_c15_flutter/core/remote/network/FireStoreManger.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/resources/StringsManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppElevatedButton.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppTextFormField.dart';
import 'package:evently_c15_flutter/core/reusable_components/DialogeUtils.dart';
import 'package:evently_c15_flutter/core/reusable_components/Switches/LocalizationAppSwitch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:evently_c15_flutter/model/User.dart' as MyUser;

class LoginScreen extends StatefulWidget {
  static String routName = "Authentification Screen";

  @override
  State<LoginScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<LoginScreen> {
  late bool isValidState;
  late TextEditingController email_controller;
  late TextEditingController password_controller;
  late TextEditingController Repassword_controller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bool isValidState = false;
    email_controller = TextEditingController();
    password_controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Center(child: Image.asset(AssetsMnager.logo)),
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

              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(ForgetPasswordScreen.routeName);
                  },
                  child: Text(
                    StringsManager.forgetPassword.tr() + "?".tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.primary,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: double.infinity,
                child: AppElevatedButton(
                  text: StringsManager.Login.tr(),
                  onPress: () {
                    isValidState = formKey.currentState!.validate();
                    SignIN();
                  },
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringsManager.having_noAccount.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      StringsManager.create_account.tr(),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).colorScheme.primary,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        height: 0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    "Or".tr(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(fontSize: 16),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        height: 0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.08,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    siginWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AssetsMnager.goolge_icon),
                      SizedBox(width: 16),
                      Text(
                        StringsManager.LoginWithGoogle.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Spacer(),

              Align(
                alignment: Alignment.center,
                child: LocalizationAppSwitch(
                  onLanguageChange: () {
                    onChangeLanguage();
                  },
                ),
              ),
              Spacer(),
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

  String? checkPassordValidation(String? value) {
    if (value!.isEmpty) {
      return StringsManager.requiredFiled.tr();
    }
    return null;
  }

  void onChangeLanguage() {
    if (!isValidState) {
      formKey.currentState?.validate();
    }
  }

  Future<void> SignIN() async {
    try {
      DialogUtils.showloadingDialoge(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text.trim(),
        password: password_controller.text,
      );
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showmessegeDialoge(
          context,
          StringsManager.noUserFound.tr(),
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.showmessegeDialoge(
          context,
          StringsManager.wrongPassword.tr(),
        );
      } else {
        DialogUtils.showmessegeDialoge(context, e.toString());
      }
    }
  }

  siginWithGoogle() async {
    try {
      final GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize();

      GoogleSignInAccount googleUser = await signIn.authenticate();

      GoogleSignInAuthentication googleAuth = googleUser.authentication;

      DialogUtils.showloadingDialoge(context);
      OAuthCredential googleCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final credential = await FirebaseAuth.instance.signInWithCredential(
        googleCredential,
      );

      FireStoreManger.saveUser(
        MyUser.User(id: credential.user?.uid, email: googleUser.email),
      );
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      print("\n ${e.toString()}");
      DialogUtils.showmessegeDialoge(context, e.toString());
    }
  }
}
