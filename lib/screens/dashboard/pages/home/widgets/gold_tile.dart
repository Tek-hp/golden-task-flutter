import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taskapp/models/gold_model.dart';

class GoldTile extends StatelessWidget {
  final GoldResponse gold;
  const GoldTile({super.key, required this.gold});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(25.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat.jm().format(
                  DateTime.fromMillisecondsSinceEpoch(gold.timestamp! * 1000),
                ),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                'Price: ${gold.price} (${gold.currency})',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(DateFormat('EEEE, MMM d, yyyy').format(
                  DateTime.fromMillisecondsSinceEpoch(gold.timestamp! * 1000))),
            ],
          ),
        ],
      ),
    );
  }
}
