import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_project/controllers/popular_product_controller.dart';
import 'package:side_project/controllers/recommended_restaurant_controller.dart';
import 'package:side_project/models/popular_products_model.dart';
import 'package:side_project/pages/restaurant/recommended_restaurant_detail.dart';
import 'package:side_project/routes/route_helper.dart';
import 'package:side_project/utils/app_constants.dart';
import 'package:side_project/utils/colors.dart';
import 'package:side_project/utils/dimensions.dart';
import 'package:side_project/widgets/app_column_restaurant.dart';
import 'package:side_project/widgets/big_text.dart';
import 'package:side_project/widgets/icon_and_text_widget.dart';
import 'package:side_project/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
     setState(() {
       _currPageValue = pageController.page!;
     });

    });
  }
  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //recommended text
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended Restaurants")
            ],
          ),
        ),
        SizedBox(height: Dimensions.height30),
        //slider section
        GetBuilder<RecommendedRestaurantController>(builder: (recommendedRestaurants){
          return recommendedRestaurants.isLoaded?Container(
            height: Dimensions.pageView,


              child: PageView.builder(
                  controller: pageController,
                  itemCount: recommendedRestaurants.recommendedRestaurantList.length,
                  itemBuilder: (context,position){
                    return _buildPageItem(position,recommendedRestaurants.recommendedRestaurantList[position]);
                  }),

          ):CircularProgressIndicator(
            color: AppColors.mainColor
          );
        }),
        //dots
        GetBuilder<RecommendedRestaurantController>(builder: (recommendedRestaurants){
              return DotsIndicator(
                dotsCount: recommendedRestaurants.recommendedRestaurantList.isEmpty?1:recommendedRestaurants.recommendedRestaurantList.length,
                position: _currPageValue,
                decorator: DotsDecorator(
                  activeColor: AppColors.mainColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              );
        }),
        SizedBox(height: Dimensions.height30),
        //popular text
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular Foods")
            ],
          ),
        ),
        //list of food and images
         GetBuilder<PopularProductController>(builder: (popularProduct){
           return popularProduct.isLoaded ? ListView.builder(
             physics: NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: popularProduct.popularProductList.length,
             itemBuilder: (context,index){
               return GestureDetector(
                 onTap: (){
                   Get.toNamed(RouteHelper.getPopularFood(index,"home"));
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
           ) : CircularProgressIndicator(
             color: AppColors.mainColor
           );
         })
      ],
    );
  }
  Widget _buildPageItem(int index, ProductModel recommendedRestaurant){

    Matrix4 matrix = new Matrix4.identity();

    if(index==_currPageValue.floor()){
      var currScale= 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans= _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale,1)
        ..setTranslationRaw(0,currTrans,0);
    }
    else if(index==_currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans= _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1,currScale,1);
      matrix = Matrix4.diagonal3Values(1,currScale,1)
        ..setTranslationRaw(0,currTrans,0);
    }
    else if(index==_currPageValue.floor()-1){
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
     else{
       var currScale = 0.8;
       matrix = Matrix4.diagonal3Values(1, currScale, 1)
         ..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);

    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getRecommendedRestaurant(index,"recommended"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.UPLOAD_URL+recommendedRestaurant.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                   BoxShadow(
                     color: Color(0xFFe8e8e8),
                     blurRadius: 5.0,
                     offset: Offset(0,5)
                   ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5,0)
                    )
                  ]


              ),
              child: Container(
                padding: EdgeInsets.only(top:Dimensions.height15,left: 15,right: 15),
                child: AppColumnRestaurant(text: recommendedRestaurant.name!),
              ),

            ),
          )
        ],
      ),
    );
  }
}
