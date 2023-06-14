import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/utils/colors.dart';


import '../data/repository/recommended_restaurant_repo.dart';
import '../models/popular_products_model.dart';

class RecommendedRestaurantController extends GetxController{
  final RecommendedRestaurantRepo recommendedRestaurantRepo;
  RecommendedRestaurantController({required this.recommendedRestaurantRepo});

  List<dynamic> _recommendedRestaurantList =[];
  List<dynamic> get recommendedRestaurantList => _recommendedRestaurantList;

  //late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity=1;
  int get quantity => _quantity;
  int _inCartItems=0;
  int get inCartItems => _inCartItems+_quantity;

  Future<void> getRecommendedRestaurantList() async{
    Response response = await recommendedRestaurantRepo.getRecommendedRestaurantList();
    if(response.statusCode==200){


      //_recommendedRestaurantList[];
      _recommendedRestaurantList.addAll(Product.fromJson(response.body).products);
      //print(_recommendedRestaurantList);
      _isLoaded = true;
      update();
    }
    else{

    }
  }
  /*
  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }
    else{
      _quantity = checkQuantity(_quantity-1);

    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<1){
      Get.snackbar("Item count", "You can't reduce more !",
        backgroundColor: AppColors.backGroundColor,
        colorText: Colors.black,);
      return 1;
    } else if((_inCartItems+quantity)>20) {
      Get.snackbar("Item count", "You can't add more !",
        backgroundColor: AppColors.backGroundColor,
        colorText: Colors.black,);
      return 20;
    }
    else {
      return quantity;
    }
  }

  void initProduct(ProductModel product ,CartController cart){
    _quantity = 1;
    _inCartItems = 0;
    _cart= cart;
    var exist=false;
    exist = _cart.existInCart(product);
    print("exist or not "+exist.toString());
    if(exist){
      _inCartItems=_cart.getQuantity(product);
    }
    print("the quantity in the cart is "+ _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    if (_quantity > 1) {
      _cart.addItem(product, _quantity);

      _quantity = 1;
      _inCartItems=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is "+value.id.toString()+" The quantity is "+value.quantity.toString());
      });
    }
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  */
}