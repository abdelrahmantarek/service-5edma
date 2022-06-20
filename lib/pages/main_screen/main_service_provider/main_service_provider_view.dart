import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/pages/profile_service_provider/profile_service_provider_view.dart';
import 'package:fixawy_app/pages/service_provider_reservation/service_provider_reservation_logic.dart';
import 'package:fixawy_app/pages/service_provider_reservation/service_provider_reservation_view.dart';
import 'package:fixawy_app/pages/settings/settings_logic.dart';
import 'package:fixawy_app/pages/settings/settings_view.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'main_service_provider_logic.dart';

class MainServiceProviderPage extends StatefulWidget {
  const MainServiceProviderPage({Key? key}) : super(key: key);
  @override
  _MainServiceProviderPageState createState() => _MainServiceProviderPageState();
}

class _MainServiceProviderPageState extends State<MainServiceProviderPage> {
  final controller = Get.put(MainServiceProviderLogic());
  final logic = Get.put(ServiceProviderReservationLogic());
  final logic2 = Get.put(SettingsLogic());

  @override
  void initState() {
    Get.find<ServiceProviderReservationLogic>().refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            overflow: Overflow.visible,
            children: [

              TabBarView(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                   const SettingsPage(),
                   const ServiceProviderReservationPage(),
                   // ProfileServiceProviderPage(
                   //   serviceProvider: ServiceProvider.fromJson(Get.find<UserData>().toJson()),
                   //   section: ServiceProvider.fromJson(Get.find<UserData>().toJson()).section,
                   // ),
                ],
              ),

            ],
          ),
          bottomNavigationBar: Obx((){

            return SalomonBottomBar(
              currentIndex: controller.currentIndex.value,
              itemPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              onTap: (index){
                if(index == 0){
                  SignInLogic.logOutPop(context);
                  return;
                }
                controller.changePage(index);
              },
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: Icon(Icons.logout),
                  title: Text(""),
                  selectedColor: Colors.purple,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: Icon(Icons.list),
                  title: Text("حجوزاتي"),
                  selectedColor: Colors.pink,
                ),

                // /// Profile
                // SalomonBottomBarItem(
                //   icon: Icon(Icons.person),
                //   title: Text("شخصي"),
                //   selectedColor: Colors.teal,
                // ),
              ],
            );


            return BottomNavigationBar(
              elevation: 0,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Get.theme.accentColor,
              onTap: (index){
                controller.changePage(index);
              },
              currentIndex: controller.currentIndex.value, items: const [
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: "الاعدادات"),
              BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp),label: "الطلبات"),
            ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ServiceProviderReservationLogic>();
    Get.delete<MainServiceProviderLogic>();
    Get.delete<SettingsLogic>();
    super.dispose();
  }
}