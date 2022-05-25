import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/pages/Regions/regions_view.dart';
import 'package:fixawy_app/network/models/Region.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixawy_app/pages/Regions/regions_logic.dart';


class SelectRegionsLogic extends RegionsLogic {}

class SelectRegionsPage extends StatefulWidget {
  static const String routeName = "/SelectRegionsPage";
  const SelectRegionsPage({Key? key}) : super(key: key);
  @override
  _SelectRegionsPageState createState() => _SelectRegionsPageState();
}

class _SelectRegionsPageState extends State<SelectRegionsPage> {
  final controller = Get.put(SelectRegionsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("كل المناطق"),
        automaticallyImplyLeading: true,
      ),
      body: Obx((){

        if(controller.loading.value){
          return const LoadingList();
        }

        return Obx((){
          return ListView.builder(itemCount: controller.list.length,itemBuilder: (context,index){
            Region region = controller.list[index];
            // bool first = customerData.id == controller.listFiltered.first.id;
            // bool last = customerData.id == controller.listFiltered.last.id;
            return ItemRegion(region: region,first: false,last: false,onTap:(){
              Get.back(result: region);
            },);
          });
        });

      }),
    );
  }

  @override
  void dispose() {
    Get.delete<SelectRegionsLogic>();
    super.dispose();
  }
}