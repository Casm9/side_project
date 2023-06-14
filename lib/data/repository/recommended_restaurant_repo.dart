import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class RecommendedRestaurantRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedRestaurantRepo({required this.apiClient});

  Future<Response> getRecommendedRestaurantList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_RESTAURANT_URI);


  }
}