import 'package:flutter_application_1/data/api/api_client.dart';
import 'package:flutter_application_1/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularPlaceRepo extends GetxService{
  final ApiClient apiClient;
  PopularPlaceRepo({required this.apiClient});

  Future<Response> getPopularPlaceList() async{
    return await apiClient.getData(AppConstants.POPPULAR_PLACE_URI);
  }
}