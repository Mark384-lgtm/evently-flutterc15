import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/core/resources/AssetsManger.dart';
import 'package:evently_c15_flutter/core/resources/ColorManger.dart';
import 'package:evently_c15_flutter/model/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem extends StatefulWidget {

  Event event;

  EventItem({required this.event});
  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  late String img_path;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setImg_Path();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(height: 250, img_path, fit: BoxFit.fitHeight),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorManger.offwhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.event.date?.toDate().day.toString()??"21",
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(fontSize: 16),
                          ),
                          Text(
                            DateFormat.MMM().format(widget.event.date!.toDate()),
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorManger.offwhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.event.title.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        SvgPicture.asset(
                          "assets/Images/heart.svg",
                          colorFilter: ColorFilter.mode(
                            ColorManger.primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  setImg_Path(){
    if(widget.event.type=="sport"){
      img_path=AssetsMnager.sport_image;
    }else if(widget.event.type=="birthday"){
      img_path=AssetsMnager.birthDay_image;
    }else{
      img_path=AssetsMnager.BookClub_image;
    }
  }
}
