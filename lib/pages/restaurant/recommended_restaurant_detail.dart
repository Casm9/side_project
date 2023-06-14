import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/controllers/recommended_restaurant_controller.dart';
import 'package:side_project/pages/home/main_food_page.dart';

import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class RecommendedRestaurantDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const RecommendedRestaurantDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var restaurant = Get.find<RecommendedRestaurantController>().recommendedRestaurantList[pageId];
    return Scaffold(
             body: Column(
               children: [
                  Container(
                   margin: EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
                   padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       GestureDetector(
                            onTap:(){
                              Get.to(()=>MainFoodPage());
                            },
                           child: AppIcon(backgroundColor:AppColors.mainColor,icon: Icons.arrow_back_ios_outlined)),
                       AppIcon(backgroundColor:AppColors.mainColor,icon: Icons.favorite_border_outlined)
                     ],
                   )
                 ),

                 Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children: [
                       BigText(text: "Foods")
                     ],
                   ),
                 SizedBox(height: Dimensions.height30),
    GetBuilder<PopularProductController>(builder: (popularProduct) {
      return popularProduct.isLoaded ?
      Expanded(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: popularProduct.popularProductList.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getPopularFood(index,"restaurant"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20,
                          right: Dimensions.width20,bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width:Dimensions.listViewImgSize,
                            height: Dimensions.listViewTextContSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        AppConstants.UPLOAD_URL+ popularProduct.popularProductList[index].img!
                                    )
                                )
                            ),
                          ),
                          //text container
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radius20),
                                    bottomRight: Radius.circular(Dimensions.radius20)
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(text: popularProduct.popularProductList[index].name!),
                                    SizedBox(height: Dimensions.height10),
                                    SmallText(text: "It is best food you have ever eaten"),
                                    SizedBox(height: Dimensions.height10),
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
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ) : CircularProgressIndicator(
          color: AppColors.mainColor
      );
    }),

    ],
             ),
           );
  }
}
