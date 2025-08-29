import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/core/resources/ColorManger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static showloadingDialoge(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(content: Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }

  static showmessegeDialoge(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: ColorManger.darkGrey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("ok".tr()),
            ),
          ],
        );
      },
    );
  }

  static showToast(String msg) {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }
}
