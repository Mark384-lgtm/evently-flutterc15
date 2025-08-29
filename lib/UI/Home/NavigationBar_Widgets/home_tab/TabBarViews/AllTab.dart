import 'package:evently_c15_flutter/UI/Home/NavigationBar_Widgets/home_tab/Widgets/EventItem.dart';
import 'package:evently_c15_flutter/core/remote/network/FireStoreManger.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/resources/ColorManger.dart';
import 'package:evently_c15_flutter/core/reusable_components/DialogeUtils.dart';
import 'package:evently_c15_flutter/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllTab extends StatefulWidget {
  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireStoreManger.getAllEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Card(
              color: Colors.grey,
              child: Container(
                height: 150,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(snapshot.error.toString()),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text("ok"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        
        List<Event> listevents=snapshot.data??[];
        return ListView.builder(
          itemBuilder: (context, index) {
            print(listevents[index].title);
            print(listevents[index].date);
            return EventItem(event: listevents[index]);
          },
          itemCount: listevents.length,
        );
      },
    );
  }
}
