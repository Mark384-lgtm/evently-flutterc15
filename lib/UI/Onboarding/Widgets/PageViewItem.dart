import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c15_flutter/UI/Onboarding/PageViewData/PageViewData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  @override
  PageViewData Pagedata;

  PageViewItem({required this.Pagedata});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(Pagedata.PagePath)),


          Text(Pagedata.title!.tr(),style: Theme.of(context).textTheme.titleMedium,),
          SizedBox(height: 20,),
          Text(
            Pagedata.textbody!.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16,)

        ],
      ),
    );
  }
}
