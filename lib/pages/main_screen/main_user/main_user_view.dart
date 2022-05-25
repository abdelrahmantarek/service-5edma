import 'package:fixawy_app/pages/complain_get/complain_get_view.dart';
import 'package:fixawy_app/pages/my_reservation/my_reservation_logic.dart';
import 'package:fixawy_app/pages/my_reservation/my_reservation_view.dart';
import 'package:fixawy_app/pages/sections/sections_logic.dart';
import 'package:fixawy_app/pages/sections/sections_view.dart';
import 'package:fixawy_app/pages/settings/settings_view.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizer/sizer.dart';
import 'main_user_logic.dart';



class MainUserPage extends StatefulWidget {
  const MainUserPage({Key? key}) : super(key: key);
  @override
  _MainUserPageState createState() => _MainUserPageState();
}

class _MainUserPageState extends State<MainUserPage> {
  final controller = Get.put(MainUserLogic());

  @override
  void initState() {
    Get.put(SectionsLogic(false));
    Get.put(MyReservationLogic());
    Get.find<SectionsLogic>().refreshController = RefreshController(initialRefresh: false);
    Get.find<MyReservationLogic>().refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Obx((){

              String text = "";

              if(controller.currentIndex.value == 0){
                text = "حجوزاتي";
              }

              if(controller.currentIndex.value == 1){
                text = "الاقسام";
              }

              if(controller.currentIndex.value == 2){
                text = "حجوزاتي";
              }

              if(controller.currentIndex.value == 3){
                text = "الشكاوى";
              }

              return Text(text,style: Get.textTheme.bodyText1);

            }),

            actions: [
              Hero(
                tag: "search",
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                      onPressed: (){
                        Get.find<SectionsLogic>().onTapSearchIcon();
                      },
                      icon: Icon(Icons.search,size: 20.sp,)),
                ),
              ),

              Container(width: 20,),

            ],
          ),
          body: Stack(
            overflow: Overflow.visible,
            children: [

              TabBarView(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SizedBox(),
                  SectionsPage(),
                  MyReservationPage(),
                  ComplainGetPage(),
                ],
              ),

            ],
          ),
          bottomNavigationBar: Obx((){

            return SalomonBottomBar(
              currentIndex: controller.currentIndex.value,
              itemPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              onTap: (index){
                print(index);

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
                  icon: Icon(Icons.menu),
                  title: Text("الاقسام"),
                  selectedColor: Colors.pink,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: Icon(Icons.line_style_outlined),
                  title: Text("حجوزاتي"),
                  selectedColor: Colors.teal,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: Icon(Icons.account_tree_sharp),
                  title: Text("الشكاوي"),
                  selectedColor: Colors.teal,
                ),

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
              BottomNavigationBarItem(icon: Icon(Icons.line_style_outlined),label: "حجوزاتي"),
              BottomNavigationBarItem(icon: Icon(Icons.menu),label: "الاقسام"),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: "الاعدادات"),
            ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<MainUserLogic>();
    Get.find<SectionsLogic>().refreshController!.dispose();
    Get.find<MyReservationLogic>().refreshController!.dispose();
    Get.delete<SectionsLogic>();
    Get.delete<MyReservationLogic>();
    super.dispose();
  }
}

