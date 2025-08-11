
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/core/resources/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/AssetsManger.dart';
import 'GeneralAppSwitch.dart';

class LocalizationAppSwitch extends StatelessWidget {
  late int selected_language;
  Function? onLanguageChange;


  LocalizationAppSwitch({this.onLanguageChange });

  @override
  Widget build(BuildContext context) {
    selected_language =
    context.locale.languageCode == Constants.enCode ? 0 : 1;
  return  GeneralAppSwitch(
    current_index: selected_language,
    iconList: [
      SvgPicture.asset(AssetsMnager.US_flag),
      SvgPicture.asset(AssetsMnager.EG_flag),
    ],
    onSwitch: (value)async {
      await changeLanguage(value , context);
      print("\nisLanguageChange is empty = ${onLanguageChange==null}");
      onLanguageChange?.call();
    },
  );
  }

  Future<void> changeLanguage(int value , BuildContext context) async{
    await context.setLocale(Locale(value == 1 ? "ar" : "en"));
    //print(selected_language);
  }

}