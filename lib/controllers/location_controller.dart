import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:side_project/data/repository/location_repo.dart';
import 'package:side_project/models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark= Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList=[];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList=["home","office","others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;



  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress=true;


  bool get loading =>_loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;


  void setMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
          _loading=true;
          update();
          try{
            if(fromAddress){
              _position=Position(
                  longitude: position.target.longitude,
                  latitude: position.target.latitude,
                  timestamp: DateTime.now(),
                  accuracy: 1,
                  altitude: 1,
                  heading: 1,
                  speed: 1,
                  speedAccuracy: 1);
            }
            else{
              _pickPosition=Position(
                  longitude: position.target.longitude,
                  latitude: position.target.latitude,
                  timestamp: DateTime.now(),
                  accuracy: 1,
                  altitude: 1,
                  heading: 1,
                  speed: 1,
                  speedAccuracy: 1);
            }
            if(_changeAddress){
              String _address = await getAddressFromGeoCode(
                LatLng(position.target.latitude, position.target.longitude)
              );
              fromAddress ? _placemark = Placemark(name: _address)
                  : _pickPlacemark = Placemark(name:  _address);
            }

          }
          catch(e){
            print(e);
          }
    }
  }

  Future<String> getAddressFromGeoCode(LatLng latLng) async{
    String _address = "Unknown location found";
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    /*
    if(response.body["status"]=='OK'){
        _address = response.body["results"][0]["formatted_address"].toString();
        print("printing address "+_address);
    }
    else{
      print("Error getting google api");
    }

     */
    _address = response.body["results"][0]["formatted_address"].toString();
    print("printing address "+_address);

    return  _address;
  }

  Map<String,dynamic>? _getAddress;
  Map? get getAddress => _getAddress;

  AddressModel getUserAddress(){
    late AddressModel _addressModel;

    //converting to map using jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }
    catch(e){
      print(e);
    }

    return _addressModel;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }
}