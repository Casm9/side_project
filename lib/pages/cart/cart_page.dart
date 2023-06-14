import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/base/no_data_page.dart';
import 'package:side_project/controllers/auth_controller.dart';
import 'package:side_project/controllers/cart_controller.dart';
import 'package:side_project/controllers/location_controller.dart';
import 'package:side_project/controllers/popular_product_controller.dart';
import 'package:side_project/pages/home/main_food_page.dart';
import 'package:side_project/routes/route_helper.dart';
import 'package:side_project/utils/app_constants.dart';
import 'package:side_project/utils/colors.dart';
import 'package:side_project/utils/dimensions.dart';
import 'package:side_project/widgets/big_text.dart';
import 'package:side_project/widgets/small_text.dart';
import '../../widgets/app_icon.dart';



class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                      AppIcon(icon:Icons.arrow_back_ios_outlined,
                          iconColor: Colors.black,
                          backgroundColor: AppColors.mainColor,
                          ),
                      SizedBox(width: Dimensions.width20*5),
                      GestureDetector(
                        onTap: (){
                         Get.toNamed(RouteHelper.getInitial());
                        },
                        child: AppIcon(icon:Icons.home_outlined,
                              iconColor: Colors.black,
                              backgroundColor: AppColors.mainColor,
                            ),
                      ),
                      AppIcon(icon:Icons.shopping_cart_outlined,
                            iconColor: Colors.black,
                            backgroundColor: AppColors.mainColor,
                          ),
          ]
          )),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.isNotEmpty?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_,index){
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20*5,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product);
                                      if(popularIndex>=0){
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                      }
                                      else if(popularIndex<0){
                                        Get.snackbar("History product","Product review is ont available for history products",
                                            backgroundColor: AppColors.mainColor,
                                            colorText: Colors.white);
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.width20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover ,
                                              image: NetworkImage(
                                                  AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                              )
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),                              Expanded(child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!),
                                        SmallText(text: "text"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "${cartController.getItems[index].price}₺",
                                                color: Colors.redAccent),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10,
                                                  bottom: Dimensions.height10,left: Dimensions.width10,
                                                  right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon( Icons.remove,color:AppColors.mainColor)),
                                                  SizedBox(width: Dimensions.width10/2),
                                                  BigText(text: _cartList[index].quantity.toString()),
                                                  SizedBox(width: Dimensions.width10/2),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child: Icon(Icons.add,color:AppColors.mainColor))
                                                ],
                                              ),

                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            );
                          });
                    }),
                  ),

                )):NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
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
            child: cartController.getItems.isNotEmpty ? Row(
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

                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: "${cartController.totalAmount}₺"),
                    SizedBox(width: Dimensions.width10/2),

                  ],
                ),

              ),
              GestureDetector(
                onTap: (){


                  if(Get.find<LocationController>().addressList.isEmpty){
                    Get.toNamed(RouteHelper.getAddressPage());
                  }
                  cartController.addToHistory();



                 // Get.toNamed(RouteHelper.getSignInPage());


                  /*
                  if(Get.find<AuthController>().userHasLoggedIn()){
                    cartController.addToHistory();
                  }else{
                    Get.toNamed(RouteHelper.getSignInPage());
                  }
                  */

                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,
                      bottom: Dimensions.height20,left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                    ),

                  child: BigText(text: "Check Out"),
                ),
              )
            ],
          ) : Container()
          );
        })

    );
  }
}
