import 'package:fixawy_app/pages/book_now/book_now_view.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/pages/complain_request/complain_request_view.dart';
import 'package:get/get.dart';

class ProfileServiceProviderLogic extends GetxController{


   Section? section;
   ServiceProvider? serviceProvider;


  ProfileServiceProviderLogic({Section? section,ServiceProvider? serviceProvider}){
    if(section != null){
      this.section = section;
    }
    if(serviceProvider != null){
      this.serviceProvider = serviceProvider;
    }
  }

  @override
  void onInit() {
    if(Get.arguments == null){
      return;
    }
    if(Get.arguments["serviceProvider"] != null){
      serviceProvider = Get.arguments["serviceProvider"];
    }
    if(Get.arguments["section"] != null){
      section = Get.arguments["section"];
    }
    super.onInit();
  }


  void book() {
    Get.toNamed(BookNowPage.routeName,arguments: {
      "serviceProvider":serviceProvider,
      "section":section
    });
  }

  void makeComplain() {
    Get.toNamed(ComplainRequestPage.routeName,arguments: serviceProvider);
  }


}
