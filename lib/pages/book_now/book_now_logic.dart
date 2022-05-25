import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/network/models/payment_method.dart';
import 'package:fixawy_app/network/models/payment_status.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/pages/payment/card_screen.dart';
import 'package:fixawy_app/pages/payment/payment_logic.dart';
import 'package:fixawy_app/pages/payment/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookNowLogic extends GetxController {


  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());

  TextEditingController notes = TextEditingController();

  RxString paymentBy = "CASH".obs;

  RxString cardNumber = "000000000000".obs;
  RxString cardName = "Name".obs;
  RxString cardCvv = "Cvv".obs;


  late Section section;
  late ServiceProvider serviceProvider;


  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate.value){
         selectedDate.value = picked;
    }
  }





  book()async{


    String id = FirebaseFirestore.instance.collection("Reservation").doc().id;

    var body = {
      "notes":notes.text,
      "paymentMethod":paymentBy.value,
      "paymentStatus":PaymentStatus.PENDING,
      "reservationId":id,
      "serviceExecutionDate":selectedDate.value.millisecondsSinceEpoch,
      "serviceProvider":serviceProvider.toJson(),
      "timeStamp":FieldValue.serverTimestamp(),
      "section":section.toJson(),
      "user":Get.find<UserData>().toJson(),
    };

    if(paymentBy.value == PaymentMethodBy.VISA){
      body.addAll({
        "paymentData":{
          "cardName":cardName.value,
          "cardNumber":cardNumber.value,
          "cardCvv":cardCvv.value,
        }
      });
    }

    try{
      var result = await FirebaseFirestore.instance.collection("Reservation").doc(id).set(body);
      success("تم الحجز بنجاح وسوف ترى حجزك في حجوزاتي");
      Get.back(result: true);
    }catch(err){
      error(err.toString());
    }

  }



  void selectPayment(BuildContext context) async{


    dynamic visa = await showModalBottomSheet(
        context:context,
        builder: (context){
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Payment Method"),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  ListTile(
                    onTap: (){
                      Get.find<BookNowLogic>().paymentBy.value = PaymentMethodBy.VISA;
                      Navigator.pop(context,true);
                    },
                    title:const Text("Visa Card"),
                    subtitle:const Text("Cridet card visa card"),
                    trailing:const Icon(Icons.check_circle_outline,color: Colors.green,),
                  ),

                  const Divider(),

                  ListTile(
                    onTap: (){
                      Get.find<BookNowLogic>().paymentBy.value = PaymentMethodBy.CASH;
                      Navigator.pop(context,false);
                    },
                    title: const Text("Cash"),
                    subtitle: const Text("cash way"),
                    trailing: const Icon(Icons.check_circle_outline,color: Colors.green,),
                  ),

                ],
              ),
            ),
          );
        }
    );


    if(visa != null && visa){
      dynamic result = await Navigator.of(context).push(MaterialPageRoute(builder: (c)=> const CardScreen()));
      if(result != null){
        cardNumber.value = result[0];
        cardName.value = result[1];
        cardCvv.value = result[2];
      }else{
        paymentBy.value = PaymentMethodBy.CASH;
      }
    }

  }


  @override
  void onInit() {
    section = Get.arguments["section"];
    serviceProvider = Get.arguments["serviceProvider"];
    super.onInit();
  }




}
