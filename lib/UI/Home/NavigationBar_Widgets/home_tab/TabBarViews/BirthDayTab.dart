import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/home_tab/Widgets/EventItem.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:flutter/material.dart';

import '../../../../../model/Event.dart';

class BirthDayTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return EventItem(event: Event(type: "birthday"),);

      },);
  }

}