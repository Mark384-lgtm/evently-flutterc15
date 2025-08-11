import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/core/resources/ColorManger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  String text;
  void Function() onPress;

  AppElevatedButton({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02),
      child: Container(
        height: MediaQuery.sizeOf(context).height*0.08,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            text.tr(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
