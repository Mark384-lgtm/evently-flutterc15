import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/UI/Home/Screen/HomeScreen.dart';
import 'package:evently_c15_flutter/UI/Onboarding/PageViewData/PageViewData.dart';
import 'package:evently_c15_flutter/UI/Onboarding/Widgets/PageViewItem.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppElevatedButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/resources/StringsManger.dart';

class onBoardingScreen extends StatefulWidget {
  static String routeNme = "onBoarding Screen";

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  late List<PageViewData> pageviewdatalist;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    pageviewdatalist = [
      PageViewData(
        PagePath: AssetsMnager.hot_trending,
        textbody: StringsManager.onBoardingBody1,
        title: StringsManager.onBoardingTitle1,
      ),
      PageViewData(
        PagePath: AssetsMnager.beding_creative_1,
        textbody: StringsManager.onBoardingBody2,
        title: StringsManager.onBoardingTitle2,
      ),
      PageViewData(
        PagePath: AssetsMnager.beding_creative_2,
        textbody: StringsManager.onBoardingBody3,
        title: StringsManager.onBoardingTitle3,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          height: 50,
          AssetsMnager.title,
          fit: BoxFit.fitHeight,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                return PageViewItem(Pagedata: pageviewdatalist[index]);
              },
              itemCount: pageviewdatalist.length,
            ),
          ),
          SmoothPageIndicator(
            effect: ExpandingDotsEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
            ),
            controller: controller,
            count: pageviewdatalist.length,
          ),
          SizedBox(height: 16),
          AppElevatedButton(
            text: StringsManager.goToHome.tr(),
            onPress: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => false,
              );
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
