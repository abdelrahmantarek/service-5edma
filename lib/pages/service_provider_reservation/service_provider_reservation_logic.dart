import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/reservation.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class ServiceProviderReservationLogic extends GetxController {

  RefreshController? refreshController;


  RxList<Reservation> list = RxList<Reservation>([]);


  RxBool loading = false.obs;


  refresh()async{
    await getMyReservation();
    refreshController!.loadComplete();
    refreshController!.refreshToIdle();
  }



  @override
  void onInit() {
    getMyReservation();
    super.onInit();
  }



  Future getMyReservation() async{
    loading.value = true;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Reservation").where("serviceProvider.id",isEqualTo: Get.find<UserData>().id).get();
    list.clear();
    for(var s in querySnapshot.docChanges){
      list.add(Reservation.fromJson(s.doc.data()!));
    }
    loading.value = false;
    return true;
  }

}
