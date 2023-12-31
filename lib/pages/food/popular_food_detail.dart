import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/controllers/cart_controller.dart';
import 'package:side_project/pages/cart/cart_page.dart';
import 'package:side_project/routes/route_helper.dart';
import 'package:side_project/utils/app_constants.dart';
import 'package:side_project/utils/dimensions.dart';
import 'package:side_project/widgets/app_column.dart';
import 'package:side_project/widgets/app_icon.dart';
import 'package:side_project/widgets/expandable_text_widget.dart';

import '../../controllers/popular_product_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../home/main_food_page.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),
          )),
          //icon widget
          Positioned(
            top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        if(page=="cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());
                        }else if(page=="restaurant"){
                          Get.toNamed(RouteHelper.getRecommendedRestaurant(pageId, page));
                        }
                        else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios_outlined)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1)
                          Get.toNamed(RouteHelper.cartPage);
                      },
                      child: Stack(
                        children:[
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems>=1?
                            Positioned(
                                right:0,
                                top:0,
                                child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.mainColor),

                            ): Container(),

                          controller.totalItems>=1?
                          Positioned(
                              right:4,
                              top:4,
                              child: BigText(
                                text: controller.totalItems.toString(),
                                size: 12,
                              )
                          ):
                          Container()
                        ]
                      ),
                    );
                  })
                ],
              )),
          //food features
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,
                    right: Dimensions.width20,top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "About"),
                    SizedBox(height: Dimensions.height20),
                    Expanded(child: SingleChildScrollView(child: ExpandableText(text: product.about! )))

                  ],
                )
              )),

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top:Dimensions.height30,bottom: Dimensions.height30,
              left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.backGroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,
                    bottom: Dimensions.height20,left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          popularProduct.setQuantity(false);
                        },
                        child: Icon( Icons.remove,color:AppColors.mainColor)),
                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2),
                    GestureDetector(
                        onTap: (){
                            popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add,color:AppColors.mainColor))
                  ],
                ),

              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,
                        bottom: Dimensions.height20,left: Dimensions.width20,
                        right: Dimensions.width20),

                      child: BigText(text: "\₺ ${product.price!} | Add to cart"),
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ),
        );
      })
    );
  }
}
