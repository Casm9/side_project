import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/controllers/cart_controller.dart';
import 'package:side_project/controllers/recommended_restaurant_controller.dart';
import 'package:side_project/pages/address/add_address_page.dart';
import 'package:side_project/pages/auth/sign_in_page.dart';
import 'package:side_project/pages/auth/sign_up_page.dart';
import 'package:side_project/pages/food/popular_food_detail.dart';
import 'package:side_project/pages/home/food_page_body.dart';
import 'package:side_project/pages/home/main_food_page.dart';
import 'package:side_project/pages/restaurant/recommended_restaurant_detail.dart';
import 'package:side_project/pages/splash/splash_page.dart';
import 'package:side_project/routes/route_helper.dart';
import 'controllers/popular_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<CartController>().getCartData();

      return GetBuilder<PopularProductController>(builder: (_){
        return GetBuilder<RecommendedRestaurantController>(builder: (_){
                return  GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'GOGO',
                  //home: AddAddressPage(),
                  initialRoute: RouteHelper.getSplashPage(),
                  getPages: RouteHelper.routes,
                );
        });
      });

  }
}
