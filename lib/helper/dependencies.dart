import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_project/controllers/auth_controller.dart';
import 'package:side_project/controllers/location_controller.dart';
import 'package:side_project/controllers/user_controller.dart';
import 'package:side_project/data/repository/auth_repo.dart';
import 'package:side_project/data/repository/location_repo.dart';
import 'package:side_project/data/repository/user_repo.dart';


import '../controllers/cart_controller.dart';
import '../controllers/popular_product_controller.dart';
import '../controllers/recommended_restaurant_controller.dart';
import '../data/api/api_client.dart';

import '../data/repository/cart_repo.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_restaurant_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async{

  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URL,
      sharedPreferences: Get.find()));


  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedRestaurantRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(()=> AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(()=> UserRepo(apiClient: Get.find()));
  Get.lazyPut(()=> LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedRestaurantController(recommendedRestaurantRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));

}