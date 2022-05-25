import 'package:fixawy_app/network/models/TimeOfWork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import 'select_times_logic.dart';

class SelectTimesPage extends StatefulWidget {
  static const String routeName = "/SelectTimesPage";
  const SelectTimesPage({Key? key}) : super(key: key);
  @override
  _SelectTimesPageState createState() => _SelectTimesPageState();
}

class _SelectTimesPageState extends State<SelectTimesPage> {
  final controller = Get.put(SelectTimesLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختار اوقات عملك"),
        automaticallyImplyLeading: true,
      ),
      body: Obx((){
        return ListView.builder(itemCount: controller.timesOfWork.length,itemBuilder: (c,index){

          TimeOfWork timeOfWork = controller.timesOfWork[index];

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
            child: Row(
              children: [
                Expanded(flex: 2,child: Text(timeOfWork.day!)),
                const Expanded(child: Text("من")),
                Expanded(flex: 2,child: InkWell(
                  onTap: ()async{
                    String? time = await controller.getTime();
                    if(time!=null){
                       timeOfWork.from = time;
                       controller.timesOfWork.refresh();
                    }
                  },
                  child: Text(timeOfWork.from!),
                )),
                const Expanded(child: Text("الى")),
                Expanded(flex: 2,child: InkWell(
                  onTap: ()async{
                    String? time = await controller.getTime();
                    if(time!=null){
                      timeOfWork.to = time;
                      controller.timesOfWork.refresh();
                    }
                  },
                  child: Text(timeOfWork.to!),
                )),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: Container(
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: RoundedLoadingButton(
            controller: RoundedLoadingButtonController(),
            height: 35,
            width: Get.width,
            borderRadius: 10,
            onPressed: () async{
              controller.selectedDone();
            },
            animateOnTap: false,
            color: Get.theme.accentColor,
            child: Text(
              "تم الانتهاء",
              style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.white),
            )),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SelectTimesLogic>();
    super.dispose();
  }
}