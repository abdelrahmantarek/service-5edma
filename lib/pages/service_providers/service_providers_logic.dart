import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/pages/payment/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceProvidersLogic extends GetxController {


  RxList<ServiceProvider> list = RxList<ServiceProvider>([]);

  RxBool loading = false.obs;

  Section? section;




  @override
  void onInit() {
    section = Get.arguments;
    getMyReservation();
    super.onInit();
  }

  Future getMyReservation() async{
    loading.value = true;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Users").where("section.id",isEqualTo: section!.id).get();
    list.clear();
    for(var s in querySnapshot.docChanges){
      list.add(ServiceProvider.fromJson(s.doc.data()!));
    }
    loading.value = false;
    return true;
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }







}
