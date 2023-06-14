import 'package:flutter/material.dart';
import 'package:side_project/widgets/big_text.dart';
import 'package:side_project/widgets/icon_and_text_widget.dart';
import 'package:side_project/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text,size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: 15,)),
            ),
            SizedBox(width: 10),
            SmallText(text: "4.5"),
            SizedBox(width: 10),
            SmallText(text: "1278"),
            SizedBox(width: 5),
            SmallText(text: "comments"),


          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.currency_lira_outlined,
                text: "79",
                iconColor: AppColors.restaurantIconColor),
            IconAndTextWidget(
                icon: Icons.local_fire_department_outlined,
                text: "325 kcal",
                iconColor: AppColors.locationIconColor),
            IconAndTextWidget(
                icon: Icons.access_time_sharp,
                text: "50 min",
                iconColor: AppColors.timeIconColor)
          ],
        )
      ],
    );
  }
}
