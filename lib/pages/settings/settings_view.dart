
import 'package:fixawy_app/app/storage/storage.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../complain_user/complain_user_view.dart';
import '../profile_service_provider/profile_service_provider_view.dart';
import 'settings_logic.dart';




class SettingsPage extends GetView<SettingsLogic> {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          const UserAvatar(),


          const SizedBox(height: 20,),


          if(Get.find<UserData>().userType == UserType.USER) Divider(height: Get.height * 10 / 100,),

          Visibility(
            visible: Get.find<UserData>().userType == UserType.USER,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              onTap: ()async{
                Get.toNamed(ComplainUserPage.routeName);
              },
              leading:const Icon(Icons.access_alarm_sharp),
              title: Text("الشكاوي",style: TextStyle(fontSize: 12.sp),),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),



          Divider(height: Get.height * 3 / 100,),

          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            onTap: ()async{
              await Storage.removeUser();
              Get.find<UserData>().fromJson(null);
              Get.offAllNamed(SignInPage.routeName);
            },
            leading:const Icon(Icons.login),
            title: Text("تسجيل الخروج",style: TextStyle(fontSize: 12.sp),),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),

          const SizedBox(height: 30,),


          const SizedBox(height: 50,)

        ],
      ),
    );
  }
}

class UserAvatar extends GetView<UserData> {
  const UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: Image.asset("assets/images/user.png", fit: BoxFit.contain).image,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    controller.name!,
                    style: TextStyle(fontFamily: "Cairo",color: Colors.black, fontSize: 12.sp),
                  ),
                  controller.aboutServiceProvider == null ? const SizedBox() : Text(
                    controller.aboutServiceProvider!,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 9.sp,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}