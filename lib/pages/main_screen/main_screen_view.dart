

import 'package:fixawy_app/pages/complain_get/complain_get_view.dart';
import 'package:fixawy_app/pages/main_screen/main_service_provider/main_service_provider_view.dart';
import 'package:fixawy_app/pages/main_screen/main_user/main_user_view.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenPage extends StatelessWidget {
  static const String routeName = "/MainScreenPage";
  const MainScreenPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    if(Get.find<UserData>().userType == UserType.ADMIN){
      return const ComplainGetPage();
    }

    return Get.find<UserData>().userType == UserType.USER ? const MainUserPage() : const MainServiceProviderPage();
  }
}






