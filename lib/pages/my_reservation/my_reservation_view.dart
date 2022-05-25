import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/pages/chat/chat_view.dart';
import 'package:fixawy_app/network/models/payment_status.dart';
import 'package:fixawy_app/network/models/reservation.dart';
import 'package:fixawy_app/pages/my_reservation/my_reservation_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class MyReservationPage extends GetView<MyReservationLogic> {
  const MyReservationPage({Key? key}) : super(key: key);
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

            return ItemView(reservation: reservation);

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
                    title: Text(reservation.section!.nameSection!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(" لقد تم الحجز من قبلك في قسم : ${"( ${reservation.section!.nameSection} )"} مع مقدم الخدمة : ${reservation.serviceProvider!.name} "),
                        Text("مقدم الخدمة : " + reservation.serviceProvider!.name.toString()),
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

class ItemView extends GetView<MyReservationLogic> {
  final Reservation reservation;
  const ItemView({Key? key,required this.reservation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      child: Material(
        child: InkWell(
          onTap: (){

          },
          child: Column(
            children: [
              Row(
                children: [

                  CircleAvatar(
                    child: ClipOval(
                      child: Image.network(reservation.serviceProvider!.image!,fit: BoxFit.cover,errorBuilder: (e,q,w){
                        return Image.asset("assets/images/DR-avatar.png");
                      },),
                    ) ,
                    radius: 40,
                  ),


                  Expanded(flex: 5,child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(reservation.section!.nameSection!,style: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),),
                        Text(reservation.serviceProvider!.name!,style: Theme.of(context).textTheme.bodySmall,maxLines: 2,),

                        const SizedBox(height: 10,),

                        Text("تاريخ الزيارة : " + DateTime.fromMillisecondsSinceEpoch(reservation.serviceExecutionDate).toString().split(" ")[0]),
                      ],
                    ),
                  )),

                  IconButton(
                    icon: const Icon(Icons.message,color: Colors.black,),
                    onPressed: (){
                      Get.toNamed(ChatPage.routeName,arguments: reservation);
                    },
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }


}



class Refresh extends GetView<MyReservationLogic> {
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
