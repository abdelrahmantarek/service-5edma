import 'package:fixawy_app/network/models/TimeOfWork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SelectTimesLogic extends GetxController {


  RxList<TimeOfWork> timesOfWork = RxList<TimeOfWork>([
    TimeOfWork("السبت","00:00","00:00"),
    TimeOfWork("الاحد","00:00","00:00"),
    TimeOfWork("الاثنين","00:00","00:00"),
    TimeOfWork("الثلاثاء","00:00","00:00"),
    TimeOfWork("الاربع","00:00","00:00"),
    TimeOfWork("الخميس","00:00","00:00"),
    TimeOfWork("الجمعه","00:00","00:00"),
  ]);

  Future<DateTime?> getDate()async{
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    return picked;
  }

  Future<String?> getTime()async{
    final TimeOfDay? time = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext? context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(Get.context!)
                .copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (time != null) {
      return time.format(Get.context!);
    }
    return null;
  }

  void selectedDone() {
    List<String> list = [];
    for(TimeOfWork time in timesOfWork){
      if(time.from != "00:00" && time.to != "00:00"){
         list.add("${time.day}  من  ${time.from}  الى  ${time.to}");
      }
    }
    Get.back(result: list.isEmpty ? null : list);
  }

}
