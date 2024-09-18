import 'package:flutter_application_1/data/repository/popular_place_repo.dart';
import 'package:get/get.dart';

class PopularPlaceController extends GetxController{
  final PopularPlaceRepo popularPlaceRepo;
  PopularPlaceController({required this.popularPlaceRepo});
  List<dynamic> _popularPlaceList=[];
  List<dynamic> get PopularPlaceList => _popularPlaceList;

  Future<void> getPopularPlaceList()async{
   Response response = await popularPlaceRepo.getPopularPlaceList();
   if(response.statusCode==200){
    _popularPlaceList=[];
    //_popularPlaceList.addAll();
    update();
   }else{
    
   }
  }
}