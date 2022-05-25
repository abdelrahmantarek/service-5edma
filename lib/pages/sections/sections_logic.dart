import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/pages/Regions/regions_view.dart';
import 'package:fixawy_app/network/models/Region.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SectionsLogic extends GetxController {

  RefreshController? refreshController;

  RxList<Section> list = RxList<Section>([]);

  RxBool loading = false.obs;

  Rx<Region?> region = Rx(null);


  final bool select;

  SectionsLogic(this.select);

  refresh()async{
    await getSections();
    refreshController!.loadComplete();
    refreshController!.refreshToIdle();
  }


  @override
  void onInit() {
    getSections();
    super.onInit();
  }

  Future getSections([Region? region]) async{
    loading.value = true;

    QuerySnapshot querySnapshot;

    List<Section> newList = [];

    if(select){

      querySnapshot = await FirebaseFirestore.instance.collection("Sections").get();

      for(var s in querySnapshot.docChanges){
        newList.add(Section.fromJson(s.doc.data()!));
      }

    }else{

      if(region != null){
        querySnapshot = await FirebaseFirestore.instance.collection("Users").where("userType",isEqualTo: "SERVICE_PROVIDER").where("region.id",isEqualTo: region.id!).get();
      }else{
        querySnapshot = await FirebaseFirestore.instance.collection("Users").where("userType",isEqualTo: "SERVICE_PROVIDER").get();
      }

      for(var s in querySnapshot.docChanges){
        newList.add(Section.fromJson(s.doc.data()!["section"]));
      }

    }

    list.value = newList.toSet().toList();
    loading.value = false;
    return true;
  }

  void onTapSearchIcon() async{
    dynamic region = await Get.toNamed(RegionsPage.routeName);
    if(region != null){
      this.region.value = region;
    }
    getSections(region);
  }

}
