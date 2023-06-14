import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/base/custom_loader.dart';
import 'package:side_project/controllers/auth_controller.dart';
import 'package:side_project/controllers/cart_controller.dart';
import 'package:side_project/controllers/user_controller.dart';
import 'package:side_project/routes/route_helper.dart';
import 'package:side_project/utils/colors.dart';
import 'package:side_project/utils/dimensions.dart';
import 'package:side_project/widgets/account_widget.dart';
import 'package:side_project/widgets/app_icon.dart';
import 'package:side_project/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userHasLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile", size: 24,
        ),
      ),
      /*
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn ? (userController.isLoading ? Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //profile icon
              Container(
                width: Dimensions.width30*5,
                height: Dimensions.height30*5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.width20*5),
                    color: AppColors.mainColor
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: Dimensions.height45+Dimensions.height30,
                ),
              ),
              SizedBox(height: Dimensions.height30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                          appIcon: AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: userController.userModel!.name)
                      ),
                      SizedBox(height: Dimensions.height20),
                      //phone
                      AccountWidget(
                          appIcon: AppIcon(
                              icon: Icons.phone,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: userController.userModel!.phone)
                      ),
                      SizedBox(height: Dimensions.height20),
                      //email
                      AccountWidget(
                          appIcon: AppIcon(
                              icon: Icons.email,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: userController.userModel!.email)
                      ),
                      SizedBox(height: Dimensions.height20),
                      //address
                      AccountWidget(
                          appIcon: AppIcon(
                              icon: Icons.location_on,
                              backgroundColor: AppColors.mainColor,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "Fill in your address")
                      ),
                      SizedBox(height: Dimensions.height20),
                      //message
                      AccountWidget(
                          appIcon: AppIcon(
                              icon: Icons.message_outlined,
                              backgroundColor: Colors.redAccent,
                              size: Dimensions.height10*5),
                          bigText: BigText(text: "Messages")
                      ),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: (){
                          /*
                            if(Get.find<AuthController>().userHasLoggedIn()){
                              Get.find<AuthController>().clearSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.offNamed(RouteHelper.getSignInPage());
                            }
                             */
                          Get.find<AuthController>().clearSharedData();
                          Get.find<CartController>().clear();
                          Get.find<CartController>().clearCartHistory();
                          Get.offNamed(RouteHelper.getSignInPage());

                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                                icon: Icons.logout,
                                backgroundColor: Colors.redAccent,
                                size: Dimensions.height10*5),
                            bigText: BigText(text: "Logout")
                        ),
                      ),
                      SizedBox(height: Dimensions.height20)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
            : CustomLoader()) : Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*18,
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                    "assets/image/youMustLogin.jpg")
                          )
                      ),
                  ),
                  SizedBox(height: Dimensions.height20),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.height20*5,
                      margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensions.font26,)),
                    ),
                  )
                ],
              )
            )
          );
        }),
        */
     body: Container(
               width: double.maxFinite,
               margin: EdgeInsets.only(top: Dimensions.height20),
                 child: Column(
                   children: [
                     //profile icon
                     Container(
                       width: Dimensions.width30*5,
                       height: Dimensions.height30*5,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(Dimensions.width20*5),
                           color: AppColors.mainColor
                       ),
                       child: Icon(
                         Icons.person,
                         color: Colors.black,
                         size: Dimensions.height45+Dimensions.height30,
                      ),
                    ),
                     SizedBox(height: Dimensions.height30),
                    Expanded(
                      child: SingleChildScrollView(
                         child: Column(
                          children: [
                            //name
                            AccountWidget(
                                 appIcon: AppIcon(
                                     icon: Icons.person,
                                     backgroundColor: AppColors.mainColor,
                                     size: Dimensions.height10*5),
                                 bigText: BigText(text: "Tony")
                             ),
                             SizedBox(height: Dimensions.height20),
                             //phone
                             AccountWidget(
                                 appIcon: AppIcon(
                                     icon: Icons.phone,
                                     backgroundColor: AppColors.mainColor,
                                     size: Dimensions.height10*5),
                                 bigText: BigText(text: "123456789")
                             ),
                             SizedBox(height: Dimensions.height20),
                             //email
                             AccountWidget(
                                 appIcon: AppIcon(
                                     icon: Icons.email,
                                     backgroundColor: AppColors.mainColor,
                                     size: Dimensions.height10*5),
                                 bigText: BigText(text: "tony@gmail.com")
                             ),
                             SizedBox(height: Dimensions.height20),
                             //address
                             AccountWidget(
                                 appIcon: AppIcon(
                                     icon: Icons.location_on,
                                     backgroundColor: AppColors.mainColor,
                                     size: Dimensions.height10*5),
                                 bigText: BigText(text: "Fill in your address")
                             ),
                             SizedBox(height: Dimensions.height20),
                             //message
                             AccountWidget(
                                 appIcon: AppIcon(
                                     icon: Icons.message_outlined,
                                     backgroundColor: Colors.redAccent,
                                    size: Dimensions.height10*5),
                                 bigText: BigText(text: "Messages")
                             ),
                             SizedBox(height: Dimensions.height20),
                             GestureDetector(
                               onTap: (){
                               /*
                                  if(Get.find<AuthController>().userHasLoggedIn()){
                                    Get.find<AuthController>().clearSharedData();
                                     Get.find<CartController>().clear();
                                     Get.find<CartController>().clearCartHistory();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                   }
                                    */
                                 Get.find<AuthController>().clearSharedData();
                                Get.find<CartController>().clear();
                                 Get.find<CartController>().clearCartHistory();
                                 Get.offNamed(RouteHelper.getSignInPage());

                             },
                              child: AccountWidget(
                                   appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.redAccent,
                                       size: Dimensions.height10*5),
                                 bigText: BigText(text: "Logout")
                              ),
                            ),
                           SizedBox(height: Dimensions.height20)
                           ],
                 ),
                      ),
                    )
                   ],
                 ),
              )
    );
  }
}
