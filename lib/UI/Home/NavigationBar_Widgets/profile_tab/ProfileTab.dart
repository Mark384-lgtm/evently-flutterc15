import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/ThemeProvider.dart';
import 'package:evently_c15_flutter/UserProvider.dart';
import 'package:evently_c15_flutter/core/resources/ColorManger.dart';
import 'package:evently_c15_flutter/core/resources/StringsManger.dart';
import 'package:evently_c15_flutter/UI/Authentication/Login/Screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedLanguage = "en";
  late ThemeProvider provider;

  late ThemeMode selected_theme;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ThemeProvider>(context);
    UserProvidedr userprovider = Provider.of<UserProvidedr>(context);
    selectedLanguage = context.locale.languageCode;
    selected_theme = provider.themeMode;

    print("\n selected theme = ${selected_theme}");

    return userprovider.currentUser == null
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 50,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),

                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomStart: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(60),
                            bottomEnd: Radius.circular(60),
                            topEnd: Radius.circular(60),
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          color: ColorManger.lightGrey,
                          size: 70,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: userprovider.currentUser == null
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userprovider.currentUser!.name!,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineMedium,
                                  ),
                                  Text(
                                    userprovider.currentUser!.email!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringsManager.language.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedLanguage,
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(16),
                              hint: Text("Select the language"),
                              items: [
                                DropdownMenuItem(
                                  value: "en",
                                  child: Text("English"),
                                ),
                                DropdownMenuItem(
                                  value: "ar",
                                  child: Text("العربية"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedLanguage = value!;
                                  context.setLocale(Locale(selectedLanguage));
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Text(
                          StringsManager.themeMode.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selected_theme == ThemeMode.light
                                  ? StringsManager.lightTheme.tr()
                                  : StringsManager.darkTheme.tr(),
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(16),
                              //hint: Text("Select the language"),
                              items: [
                                DropdownMenuItem(
                                  value: StringsManager.lightTheme.tr(),
                                  child: Text(StringsManager.lightTheme.tr()),
                                ),
                                DropdownMenuItem(
                                  value: StringsManager.darkTheme.tr(),
                                  child: Text(StringsManager.darkTheme.tr()),
                                ),
                              ],
                              onChanged: (value) {
                                provider.changeTheme(
                                  value == StringsManager.darkTheme.tr()
                                      ? ThemeMode.dark
                                      : ThemeMode.light,
                                );
                              },
                            ),
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFF5659),
                            padding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.routName,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.logout, size: 24, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                "logout".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
