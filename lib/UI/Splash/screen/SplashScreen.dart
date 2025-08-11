
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../SetUp/Screen/SetUpScreen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "Splash Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetsMnager.logo)
            .animate(
              onComplete: (controller) {
                Navigator.pushReplacementNamed(context, SetUpScreen.routeName);
              },
            )
            .scale(duration: Duration(seconds: 6)),
      ),
    );
  }
}
