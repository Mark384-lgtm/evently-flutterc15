import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class GeneralAppSwitch extends StatelessWidget {
  int current_index;
  List<SvgPicture>iconList;
  void Function(int value) onSwitch;
  GeneralAppSwitch({required this.current_index , required this.iconList,required this.onSwitch});

  @override
  Widget build(BuildContext context) {
    return   AnimatedToggleSwitch.rolling(
      current: current_index,
      values: [0, 1],
      iconList: iconList,
      style: ToggleStyle(
        backgroundColor: Colors.transparent,
        borderColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,
      ),
      inactiveOpacity: 1,
      iconOpacity: 1,
      onChanged: onSwitch,
    );
  }

}