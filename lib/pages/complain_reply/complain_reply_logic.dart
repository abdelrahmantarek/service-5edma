import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/network/models/Complain.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../complain_get/complain_get_logic.dart';

class ComplainReplyLogic extends GetxController {

  TextEditingController textEditingController = TextEditingController();

  late Complain complain;

  @override
  void onInit() {
    complain = Get.arguments;
    super.onInit();
  }

  void sendReply() {
    Get.find<ComplainGetLogic>().replyOnComplain(complain,textEditingController.text);
    success("لقد تم الرد على الشكوى بنجاح");
    Get.back(result: true);
  }

}
