import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainServiceProviderLogic extends GetxController with GetSingleTickerProviderStateMixin{

  RxInt currentIndex = 0.obs;
  RxBool showBadge = true.obs;
  TabController? tabController;


  @override
  void onInit() {
    tabController = TabController(initialIndex: currentIndex.value, vsync: this, length: 3);
    super.onInit();
  }

  void changePage(int index) {
    currentIndex.value = index;
    tabController!.animateTo(currentIndex.value,duration: const Duration(milliseconds: 1), curve: Curves.easeOut);
  }

}