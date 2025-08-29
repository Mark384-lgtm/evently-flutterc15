import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/core/remote/network/FireStoreManger.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/resources/ColorManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppElevatedButton.dart';
import 'package:evently_c15_flutter/core/reusable_components/AppTextFormField.dart';
import 'package:evently_c15_flutter/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/reusable_components/DialogeUtils.dart';

class AddEvent extends StatefulWidget {
  static String routeName = "Add Event Screen";

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> with TickerProviderStateMixin {
  late TabController tabController;

  int selectedIndex = 0;
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (tabController.index != selectedIndex) {
        setState(() {
          selectedIndex = tabController.index;
        });
      }
    });
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
        titleTextStyle: Theme.of(
          context,
        ).appBarTheme.titleTextStyle?.copyWith(color: ColorManger.primaryColor),
        iconTheme: IconThemeData(color: ColorManger.primaryColor),
      ),

      body: Column(
        children: [
          SizedBox(height: 16),
          SizedBox(
            height: 203,
            child: TabBarView(
              controller: tabController,
              children: [
                Image.asset(AssetsMnager.birthDay_image),
                Image.asset(AssetsMnager.BookClub_image),
                Image.asset(AssetsMnager.sport_image),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        controller: tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        indicatorColor: Colors.red,
                        labelColor: Colors.white,
                        unselectedLabelColor: ColorManger.primaryColor,
                        dividerHeight: 0,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          border: Border.all(color: ColorManger.primaryColor),
                          color: ColorManger.primaryColor,
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
                                border: Border.all(
                                  color: ColorManger.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/bike.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 0
                                          ? Colors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
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
                                border: Border.all(
                                  color: ColorManger.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/cake.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 1
                                          ? Colors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
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
                                border: Border.all(
                                  color: ColorManger.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/Images/book-open.svg",
                                    height: 24,
                                    width: 24,
                                    colorFilter: ColorFilter.mode(
                                      selectedIndex == 2
                                          ? Colors.white
                                          : Theme.of(
                                              context,
                                            ).colorScheme.primary,
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
                      SizedBox(height: 16),
                      Text(
                        "Title",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 8),
                      AppTextFormField(
                        validationAlgorithm: (value) {
                          if (value == null || value.isEmpty) {
                            return "shouldEmpty".tr();
                          }
                          return null;
                        },
                        controller: titleController,
                        hint: "Event Title",
                        prefixIcon: Icons.event_note,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 8),
                      AppTextFormField(
                        validationAlgorithm: (value) {
                          if (value == null || value.isEmpty) {
                            return "shouldEmpty".tr();
                          }
                          return null;
                        },
                        maxLine: 5,
                        controller: descController,
                        hint: "Event Description",
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/Images/Calendar_Days.svg",
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Event Date",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              selectEventDate();
                            },
                            child: Text(
                              selectedDate == null
                                  ? "Choose Date"
                                  : DateFormat.yMd().format(selectedDate!),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: ColorManger.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/Images/Clock.svg",
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Event Time",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              selectEventTime();
                            },
                            child: Text(
                              selectedTime == null
                                  ? "Choose Time"
                                  : "${selectedTime!.hourOfPeriod}:${selectedTime!.minute}${selectedTime!.period.name}",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: ColorManger.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Event Location",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: SvgPicture.asset(
                                "assets/Images/location.svg",
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Choose Event Location",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(color: ColorManger.primaryColor),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      AppElevatedButton(
                        text: "Add Event",
                        onPress: () async {
                          if (formKey.currentState!.validate()) {
                            try{
                              var event = Event(
                                  title: titleController.text,
                                  description: descController.text,
                                  date: Timestamp.fromDate(
                                    DateTime(
                                      selectedDate!.year,
                                      selectedDate!.month,
                                      selectedDate!.day,
                                      selectedTime!.hour,
                                      selectedTime!.minute,
                                    ),
                                  ),
                                  type:checkEventType(selectedIndex)
                              );
                              DialogUtils.showloadingDialoge(context);
                              await FireStoreManger.saveEvent(event);
                              Navigator.pop(context);
                              DialogUtils.showToast("Event Saved Successfully");
                            }catch(e){
                              DialogUtils.showToast("you need to Select Date and time");
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String checkEventType(int selectedIndex) {
    if (selectedIndex == 0) {
      return "sport";
    } else if (selectedIndex == 1) {
      return "birthday";
    } else {
      return "book";
    }
  }

  DateTime? selectedDate;

  void selectEventDate() async {
    var date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: selectedDate,
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  TimeOfDay? selectedTime;

  void selectEventTime() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime == null ? TimeOfDay.now() : selectedTime!,
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }
}
