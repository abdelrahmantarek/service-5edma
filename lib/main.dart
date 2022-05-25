
import 'package:firebase_core/firebase_core.dart';
import 'package:fixawy_app/pages/book_now/book_now_view.dart';
import 'package:fixawy_app/pages/chat/chat_view.dart';
import 'package:fixawy_app/pages/complain_get/complain_get_view.dart';
import 'package:fixawy_app/pages/main_screen/main_screen_view.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/pages/profile_service_provider/profile_service_provider_view.dart';
import 'package:fixawy_app/pages/service_providers/service_providers_view.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/select_regions/select_region_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/select_section/select_section_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/select_times/select_times_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/sign_up_service_provider_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'app/storage/storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'pages/Regions/regions_view.dart';
import 'pages/complain_reply/complain_reply_view.dart';
import 'pages/complain_request/complain_request_view.dart';
import 'pages/complain_user/complain_user_view.dart';
import 'pages/rating_add/rating_add_view.dart';
import 'pages/rating_service_provider/rating_service_provider_view.dart';
import 'pages/user/sign_up_user_view.dart';





void main() async{

  await GetStorage.init();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeData.light().appBarTheme.color
  ));

  if(await Storage.userExist()){
    Get.put(UserData.fromJson(await Storage.getUser()));
    print("welcome : ${Get.find<UserData>().name}");
  }else{
    Get.put(UserData());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return OverlaySupport.global(child: Sizer(builder: (q,w,e){

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:(){
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: GetMaterialApp(
          title: 'Service App',
          theme: ThemeData.light().copyWith(
            // scaffoldBackgroundColor: Colors.white.withOpacity(0.96),
            // accentColor:const Color(0xFF0148A4),
            primaryColor: Colors.green,
            appBarTheme: AppBarTheme(
              backgroundColor:Colors.white.withOpacity(0.20),
              elevation: 0,
              centerTitle: true,
              titleTextStyle:  TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold
              ),
              iconTheme: const IconThemeData(
                color: Colors.black
              )
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              isDense: true,
              hoverColor: Colors.white,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white,width: 0.9,style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white,width: 0.9,style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green,width: 0.9,style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),

              // alignLabelWithHint: true,
              hintStyle: TextStyle(
                fontFamily: "Nunito",
                color: Colors.grey,
                fontSize: 15,
              ),
              labelStyle: TextStyle(
                fontFamily: "Nunito",
                color: Colors.green,
                fontSize: 15,
              ),
            ),

            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.green,
              padding: EdgeInsets.only(right: 30,left: 30,bottom: 20,top: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),

            iconTheme: const IconThemeData(
              color: Colors.green,
            ),

            // colorScheme: const ColorScheme.dark(
            //   primary: Color(0xFF),
            // ),
            unselectedWidgetColor:Colors.green,
          ),


          textDirection: TextDirection.rtl,
          // textDirection: TextDirection.rtl,
          debugShowCheckedModeBanner: false,
          initialRoute:Get.find<UserData>().isNull.value ? SignInPage.routeName : MainScreenPage.routeName,
          // initialRoute:SignUpServiceProviderPage.routeName,
          defaultTransition:Transition.native,
          getPages: [
            GetPage(name: SignInPage.routeName, page: () => const SignInPage()),
            GetPage(name: SignUpUserPage.routeName, page: () => const SignUpUserPage()),
            GetPage(name: MainScreenPage.routeName, page: () => const MainScreenPage()),
            GetPage(name: ChatPage.routeName, page: () => const ChatPage()),
            GetPage(name: ServiceProvidersPage.routeName, page: () => const ServiceProvidersPage()),
            GetPage(name: BookNowPage.routeName, page: () => const BookNowPage()),
            GetPage(name: SignUpServiceProviderPage.routeName, page: () => const SignUpServiceProviderPage()),
            GetPage(name: SelectSectionPage.routeName, page: () => const SelectSectionPage()),
            GetPage(name: SelectRegionsPage.routeName, page: () => const SelectRegionsPage()),
            GetPage(name: SelectTimesPage.routeName, page: () => const SelectTimesPage()),
            GetPage(name: ProfileServiceProviderPage.routeName, page: () => const ProfileServiceProviderPage()),
            GetPage(name: RegionsPage.routeName, page: () => const RegionsPage()),
            GetPage(name: ComplainRequestPage.routeName, page: () => const ComplainRequestPage()),
            GetPage(name: ComplainGetPage.routeName, page: () => const ComplainGetPage()),
            GetPage(name: ComplainReplyPage.routeName, page: () => const ComplainReplyPage()),
            GetPage(name: ComplainUserPage.routeName, page: () => const ComplainUserPage()),
            GetPage(name: RatingAddPage.routeName, page: () => const RatingAddPage()),
            GetPage(name: RatingServiceProviderPage.routeName, page: () => const RatingServiceProviderPage()),
          ],

        ),

      );
    }));


  }
}

//   static const String routeName = "/SignInPage";


extension GetExtention on GetInterface{

  backToAndOffAll(String to){
    int s = 1;
    while(s<30){
      back();
      if(currentRoute == to){
        toNamed(to);
        return;
      }
      s++;
    }
  }

  backToAndOffAllAndNavigateTo(String backTo,String navigateTo){
    int s = 1;
    while(s<30){
      back();
      if(currentRoute == backTo){
        toNamed(navigateTo);
        return;
      }
      s++;
    }
  }

}

