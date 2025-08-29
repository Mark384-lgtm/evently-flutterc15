import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/UI/AddEvent/Screen/AddEvent.dart';
import 'package:evently_c15_flutter/UI/Authentication/Login/Screen/Login.dart';
import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets//home_tab/homeTab.dart';
import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/profile_tab/ProfileTab.dart';
import 'package:evently_c15_flutter/UserProvider.dart';
import 'package:evently_c15_flutter/core/remote/network/FireStoreManger.dart';
import 'package:evently_c15_flutter/model/User.dart' as MyUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  static String routeName = "Home Screen";
  List<Widget> tabView = [homeTab(), Placeholder(), Placeholder(), ProfileTab()];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late UserProvidedr userProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routName,
          (route) => false,
        );
      }
    });
    userProvider = Provider.of<UserProvidedr>(context,listen: false);
    userProvider.fetchUser(FirebaseAuth.instance.currentUser!.uid);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEvent.routeName);
        },
        child: Icon(Icons.add, size: 50, color: Colors.white),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (newIndex) {
          setState(() {
            selectedIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "home".tr(),
            icon: SvgPicture.asset("assets/Images/home.svg"),
            activeIcon: SvgPicture.asset("assets/Images/home_selected.svg"),
          ),
          BottomNavigationBarItem(
            label: "map".tr(),
            icon: SvgPicture.asset("assets/Images/map.svg"),
            activeIcon: SvgPicture.asset("assets/Images/map_selected.svg"),
          ),
          BottomNavigationBarItem(
            label: "love".tr(),
            icon: SvgPicture.asset("assets/Images/heart.svg"),
            activeIcon: SvgPicture.asset("assets/Images/heart_selected.svg"),
          ),
          BottomNavigationBarItem(
            label: "profile".tr(),
            icon: SvgPicture.asset("assets/Images/user.svg"),
            activeIcon: SvgPicture.asset("assets/Images/user_selected.svg"),
          ),
        ],
      ),
      body: widget.tabView[selectedIndex],
    );
  }
}
