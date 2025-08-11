import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/ThemeProvider.dart';
import 'package:evently_c15_flutter/UI/Home/Screen/HomeScreen.dart';
import 'package:evently_c15_flutter/UI/Onboarding/Screen/OnBoardingScreen.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/resources/StringsManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppElevatedButton.dart';
import 'package:evently_c15_flutter/core/reusable_components/Switches/GeneralAppSwitch.dart';
import 'package:evently_c15_flutter/UI/Authentication/Login/Screen/Login.dart';
import 'package:evently_c15_flutter/core/reusable_components/Switches/LocalizationAppSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SetUpScreen extends StatefulWidget {
  static String routeName = "First on Boarding Screen";

  @override
  State<SetUpScreen> createState() => _SetUpScreenState();
}

class _SetUpScreenState extends State<SetUpScreen> {
  late int selected_theme;
  late ThemeProvider themeProvider;


  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    selected_theme = themeProvider.themeMode == ThemeMode.dark ? 1 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          height: 50,
          AssetsMnager.title,
          fit: BoxFit.fitHeight,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.5 * 0.03),
          Expanded(
            child: Image.asset(
              themeProvider.themeMode == ThemeMode.light
                  ? AssetsMnager.being_creative
                  : AssetsMnager.designer_desk,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    StringsManager.firstOnBoardingScreen_title.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 * 0.05,
                  ),
                  Text(
                    StringsManager.firstOnBoardingScreen_textbody.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 * 0.03,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.localizationSwitch_title.tr(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        LocalizationAppSwitch(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 * 0.05,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringsManager.ThemingSwitch_title.tr(),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        GeneralAppSwitch(
                          current_index: selected_theme,
                          iconList: [
                            SvgPicture.asset(
                              AssetsMnager.sun,
                              colorFilter: ColorFilter.mode(
                                selected_theme == 0
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            SvgPicture.asset(
                              AssetsMnager.moon,
                              colorFilter: ColorFilter.mode(
                                selected_theme == 1
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                          onSwitch: changeTheme,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 * 0.09,
                  ),
                  AppElevatedButton(
                    text: StringsManager
                        .firstOnBoardingScreen_floatingBtn_title,
                    onPress: () {
                      Navigator.of(
                        context,
                      ).pushNamed(onBoardingScreen.routeNme);
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5 * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeTheme(int value) {
    setState(() {
      themeProvider.changeTheme(value == 1 ? ThemeMode.dark : ThemeMode.light);
    });
    //print(selected_theme);
  }
}
