import 'package:flutter_application_1/controllers/popular_place_controller.dart';
import 'package:flutter_application_1/data/api/api_client.dart';
import 'package:flutter_application_1/data/repository/popular_place_repo.dart';
import 'package:get/get.dart';

Future<void> init()async {
  //api client
  Get.lazyPut(()=>ApiClient(appBaseUrl: "https://www.dbestech.com"));
  
  //repos
  Get.lazyPut(()=>PopularPlaceRepo(apiClient: Get.find()));
  
  //controllers
  Get.lazyPut(()=>PopularPlaceController(popularPlaceRepo: Get.find()));
}