import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/pages/home/food_page_body.dart';
import 'package:side_project/utils/colors.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_restaurant_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';


class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async{
    await Get.find<RecommendedRestaurantController>().getRecommendedRestaurantList();
    await Get.find<PopularProductController>().getPopularProductList();
  }
  @override
  Widget build(BuildContext context) {
    //print("current height is "+ MediaQuery.of(context).size.height.toString());
    //print("current width is "+ MediaQuery.of(context).size.width.toString());
    return RefreshIndicator(child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(children: [
                          BigText(text: "Istanbul",color: Colors.black,size: 25,),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],)
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.width45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search,color: Colors.black,size: Dimensions.iconSize24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius30),
                            color: AppColors.mainColor
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //showing the body
            Expanded(
                child: SingleChildScrollView(
                    child: FoodPageBody() ))

          ],
        )
    , onRefresh: _loadResource);
  }
}
