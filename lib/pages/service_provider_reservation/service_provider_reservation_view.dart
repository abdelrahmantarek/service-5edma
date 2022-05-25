import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/pages/chat/chat_view.dart';
import 'package:fixawy_app/network/models/payment_status.dart';
import 'package:fixawy_app/network/models/reservation.dart';
import 'package:fixawy_app/pages/service_provider_reservation/service_provider_reservation_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';





class ServiceProviderReservationPage extends GetView<ServiceProviderReservationLogic> {
  const ServiceProviderReservationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx((){

      if(controller.loading.value){
        return const LoadingList();
      }

      return Obx((){
        return Refresh(
          child: !controller.loading.value  && controller.list.isEmpty ? const EmptyList(
            text: "لا يوجد حجوزات لك",
          ) : ListView.builder(itemCount: controller.list.length,itemBuilder: (context,index){
            Reservation reservation = controller.list[index];
            // bool first = customerData.id == controller.listFiltered.first.id;
            // bool last = customerData.id == controller.listFiltered.last.id;
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: false ? 30 : 0,bottom: false ? 50 : 0),
                  child: ListTile(
                    minVerticalPadding: 10,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                    onTap: ()async{

                    },
                    leading: Image.asset("assets/icons/booking.png"),
                    // title: Text(DateTime.fromMillisecondsSinceEpoch(reservation.serviceExecutionDate).toString().split(" ")[0]),
                    title: Text(reservation.user!.name!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("لقد تم الحجز من ${reservation.user!.name}"),
                        Text(reservation.notes!,maxLines: 3,),
                        Text("وضع الدفع : " + reservation.paymentStatus.toString(),style: TextStyle(
                            color: reservation.paymentStatus == PaymentStatus.PENDING ? Colors.deepOrange : Colors.green
                        ),),
                        Text("طريقة الدفع : " + reservation.paymentMethod.toString()),
                        Text("وقت تنفيذ الخدمة : " + DateTime.fromMillisecondsSinceEpoch(reservation.serviceExecutionDate).toString().split(" ")[0]),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.message),
                      onPressed: (){
                        Get.toNamed(ChatPage.routeName,arguments: reservation);
                      },
                    ),
                  ),
                ),
                const Divider(height: 0.3,),
              ],
            );
          }),
        );
      });

    });
  }
}


class Refresh extends GetView<ServiceProviderReservationLogic> {
  final Widget? child;
  const Refresh({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(
        waterDropColor: Get.theme.primaryColor,
      ),
      footer: CustomFooter(
        height: 250,
        builder: (BuildContext context,LoadStatus? mode){
          return const SizedBox(
            height: 55.0,
            child: Center(),
          );
        },
      ),
      controller: controller.refreshController!,
      onRefresh: controller.refresh,
      // onLoading: controller.onLoadingRefresh,
      child:child,
    );
  }
}

