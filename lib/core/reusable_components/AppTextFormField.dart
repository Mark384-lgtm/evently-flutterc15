import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  String? Function(String? value) validationAlgorithm;
  TextEditingController controller;
  String hint;
  IconData? prefixIcon;
  bool isPasswordField;
  int maxLine;

  AppTextFormField({
    this.maxLine=1,
    required this.validationAlgorithm,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.isPasswordField = false,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: TextFormField(
        maxLines: widget.maxLine ,
        keyboardType: widget.isPasswordField
             ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        controller: widget.controller,
        validator: widget.validationAlgorithm,
        obscureText: isVisiblePassword,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: widget.hint.tr(),
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 16,
          ),
          prefixIcon: Icon(
            widget.prefixIcon ?? null,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          suffixIcon: widget.isPasswordField
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isVisiblePassword = !isVisiblePassword;
                    });
                  },
                  child: Icon(
                    !isVisiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 16,
        ),
      ),
    );
  }
}
