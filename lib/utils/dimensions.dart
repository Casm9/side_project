import 'package:get/get.dart';

class Dimensions{

  static double screenHeight= Get.context!.height;
  static double screenWidth= Get.context!.width;

  //802.9090909090909/300 = 2.67
  static double pageView=screenHeight/2.67;
  //802.9090909090909/220 = 3.65
  static double pageViewContainer= screenHeight/3.65;
  //802.9090909090909/120 = 6.69
  static double pageViewTextContainer= screenHeight/6.69;

  static double height10 = screenHeight/80.2;
  static double height15 = screenHeight/53.5;
  static double height20 = screenHeight/40.1;
  static double height30 = screenHeight/26.7;
  static double height45 = screenHeight/17.8;

  static double width10 = screenHeight/80.2;
  static double width15 = screenHeight/53.5;
  static double width20 = screenHeight/40.1;
  static double width30 = screenHeight/26.7;
  static double width45 = screenHeight/17.8;

  static double font16 = screenHeight/50.1;
  static double font20 = screenHeight/40.1;
  static double font26 = screenHeight/30.8;

  static double radius20 = screenHeight/40.1;
  static double radius30 = screenHeight/26.7;

  static double iconSize24 = screenHeight/33.4;
  static double iconSize16 = screenHeight/50.1;

  //392.72727272727275/120 = 3.27
  static double listViewImgSize = screenWidth/3.27;
  static double listViewTextContSize = screenWidth/3.92;

  static double popularFoodImgSize = screenHeight/2.3;

  static double bottomHeightBar= screenHeight/6.69;








}