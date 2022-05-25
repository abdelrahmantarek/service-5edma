import 'package:fixawy_app/CustomWidget/edit_text.dart';
import 'package:fixawy_app/network/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'book_now_logic.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class BookNowPage extends StatefulWidget {
  static const String routeName = "/BookNowPage";
  const BookNowPage({Key? key}) : super(key: key);
  @override
  _BookNowPageState createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  final BookNowLogic controller = Get.put(BookNowLogic());

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Booking"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children:  [

              Obx((){
                return ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  onTap: (){
                    controller.selectDate(context);
                  },
                  title: const Text("ميعاد الحجز"),
                  subtitle: Text(controller.selectedDate.toString().split(" ")[0]),
                );
              }),



              const Divider(height: 0.5,),


              Obx((){
                return ListTile(
                  contentPadding: const EdgeInsets.all(20),
                  onTap: (){
                    controller.selectPayment(context);
                  },
                  title: const Text("طريقة الدفع"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.paymentBy.value),


                      controller.paymentBy.value  == PaymentMethodBy.CASH ? const SizedBox() :

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 15,),

                          Text("card number : ${controller.cardName}"),
                          Text("card name : ${controller.cardNumber}"),
                          Text("card cvv : ${controller.cardCvv}"),

                        ],
                      )

                    ],
                  ),
                );
              }),



              const Divider(height: 0.5,),



              const ListTile(
                contentPadding: EdgeInsets.all(20),
                title: Text("اضف ملاحظات لمقدم خدمتك"),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: EditText(
                  controller: controller.notes,
                  hint: "ملاحظاتك",
                  maxLines: 5,
                  minLines: 5,
                  maxLength: 10000,
                ),
              ),


            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: Get.width,
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: RoundedLoadingButton(
              controller: RoundedLoadingButtonController(),
              height: 35,
              width: Get.width,
              borderRadius: 10,
              onPressed: () async{
                controller.book();
              },
              animateOnTap: false,
              color: Get.theme.accentColor,
              child: Text(
                "دفع",
                style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.white),
              )),
        ),
      );
  }

  @override
  void dispose() {
    Get.delete<BookNowLogic>();
    super.dispose();
  }


}

