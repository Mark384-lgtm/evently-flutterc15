import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/ThemeProvider.dart';
import 'package:evently_c15_flutter/UI/Authentication/ForgetPassword/Screen/ForgetPasswordScreen.dart';
import 'package:evently_c15_flutter/UI/Authentication/Register/Screen/RegisterScreen.dart';
import 'package:evently_c15_flutter/UI/Home/Screen/HomeScreen.dart';
import 'package:evently_c15_flutter/UI/Onboarding/Screen/OnBoardingScreen.dart';
import 'package:evently_c15_flutter/UI/Splash/screen/SplashScreen.dart';
import 'package:evently_c15_flutter/UI/Authentication/Login/Screen/Login.dart';
import 'package:evently_c15_flutter/core/remote/local/PrefManger.dart';
import 'package:evently_c15_flutter/core/resources/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'UI/SetUp/Screen/SetUpScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefManger.inti();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en"), Locale("ar")],
      path: 'assets/translations',
      startLocale: Locale("ar"),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider()..init(),
        child: Builder(
          builder: (context) {
            ThemeProvider themeprovider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              themeMode: themeprovider.themeMode,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              initialRoute: SplashScreen.routeName,
              routes: {
                SplashScreen.routeName: (_) => SplashScreen(),
                SetUpScreen.routeName: (_) => SetUpScreen(),
                LoginScreen.routName: (_) => LoginScreen(),
                RegisterScreen.routeName: (_) => RegisterScreen(),
                ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
                HomeScreen.routeName:(_)=>HomeScreen(),
                onBoardingScreen.routeNme:(_)=>onBoardingScreen()
              },
            );
          },
        ),
      ),
    ),
  );
}
