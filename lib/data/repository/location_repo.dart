import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:side_project/data/api/api_client.dart';
import 'package:side_project/utils/app_constants.dart';

class LocationRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo ({required this.apiClient,required this.sharedPreferences});

  Future<Response> getAddressFromGeoCode(LatLng latLng) async{
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

  String getUserAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)??"";
  }
}