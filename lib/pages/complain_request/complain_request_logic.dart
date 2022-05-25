import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/providers/WorkerProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ComplainRequestLogic extends GetxController with WorkerProvider{

  TextEditingController textEditingController = TextEditingController();

  late ServiceProvider serviceProvider;



  makeComplain()async{

    if(textEditingController.text.isEmpty){
      error("من فضلك قم بكتابة الشكوى");
      return;
    }

    await makeComplainByWorker(serviceProvider, textEditingController.text);

    success("لقد تم ارسال الشكوى بنجاح");

    Get.back(result: true);
  }


  @override
  void onInit() {
    serviceProvider = Get.arguments;
    super.onInit();
  }
}
