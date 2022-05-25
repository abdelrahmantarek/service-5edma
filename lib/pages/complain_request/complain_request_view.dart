import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'complain_request_logic.dart';


class ComplainRequestPage extends StatefulWidget {
  static const String routeName = "/ComplainRequestPage";
  const ComplainRequestPage({Key? key}) : super(key: key);
  @override
  _ComplainRequestPageState createState() => _ComplainRequestPageState();
}

class _ComplainRequestPageState extends State<ComplainRequestPage> {
  final controller = Get.put(ComplainRequestLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("عمل شكوى"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const SizedBox(height: 50,),


            const ListTile(
              title: Text("برجاء كتابة الشكوى الخاصة بك"),
            ),

            Padding(
              padding:const  EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller.textEditingController,
                maxLines: 5,
                minLines: 5,
                decoration: const InputDecoration(
                  hintText: "برجاء كتابة الشكوى"
                ),
              ),
            )

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
              controller.makeComplain();
            },
            animateOnTap: false,
            color: Colors.red,
            child: Text(
              "عمل شكوى",
              style: Get.textTheme.button!.copyWith(fontSize: 15,color: Colors.white),
            )),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ComplainRequestLogic>();
    super.dispose();
  }
}