import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/home_tab/TabBarViews/AllTab.dart';
import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/home_tab/TabBarViews/BirthDayTab.dart';
import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/home_tab/TabBarViews/BookClub.dart';
import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/home_tab/TabBarViews/SportTab.dart';
import 'package:evently_c15_flutter/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class homeTab extends StatefulWidget {
  @override
  State<homeTab> createState() => _homeTabState();
}

class _homeTabState extends State<homeTab> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.index != selectedIndex) {
        setState(() {
          selectedIndex = tabController.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvidedr userProvider = Provider.of<UserProvidedr>(context);
    print("email : ${Provider.of<UserProvidedr>(context).currentUser?.email}");
    return userProvider.currentUser == null
        ? Center(child: CircularProgressIndicator())
        : DefaultTabController(
            length: 5,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.only(
                    start: 16,
                    end: 16,
                    bottom: 16,
                    top: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiary,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(24),
                      bottomStart: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "welcome".tr(),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                      ),
                      userProvider.currentUser == null
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                              userProvider.currentUser!.name!,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/Images/map.svg",
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Cairo , Egypt",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        indicatorColor: Colors.red,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.white,
                        dividerHeight: 0,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                        ),
                        tabs: [
                          Tab(
                            height: 50,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/Compass.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 0
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text("All"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            height: 50,

                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/bike.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 1
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text("Sport"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            height: 50,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/cake.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 2
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text("Birthday"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            height: 50,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/book-open.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 3
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                          : Colors.white,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text("Book Club"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        AllTab(),
                        sportTab(),
                        BirthDayTab(),
                        BookClubTab(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
