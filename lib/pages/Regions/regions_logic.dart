import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/Region.dart';
import 'package:get/get.dart';

class RegionsLogic extends GetxController {

  RxList<Region> list = RxList<Region>([]);

  RxBool loading = false.obs;


  @override
  void onInit() {
    getSections();
    super.onInit();
  }



  Future getSections() async{
    loading.value = true;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Regions").get();
    list.clear();
    for(var s in querySnapshot.docChanges){
      list.add(Region.fromJson(s.doc.data()!));
    }
    loading.value = false;
    return true;
  }

}
