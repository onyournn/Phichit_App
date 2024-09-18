import 'package:flutter_application_1/data/api/api_client.dart';
import 'package:get/get.dart';

class PopularPlaceRepo extends GetxService{
  final ApiClient apiClient;
  PopularPlaceRepo({required this.apiClient});

  Future<Response> getPopularPlaceList() async{
    return await apiClient.getData("https://www.dbestech.com/api/place/list");
  }
}