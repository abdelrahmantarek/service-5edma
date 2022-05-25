import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/pages/sections/sections_logic.dart';
import 'package:fixawy_app/pages/sections/sections_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class SelectSectionLogic extends SectionsLogic {
  SelectSectionLogic(bool select) : super(select);
}

class SelectSectionPage extends StatefulWidget {
  static const String routeName = "/SelectSectionPage";
  const SelectSectionPage({Key? key}) : super(key: key);
  @override
  _SelectSectionPageState createState() => _SelectSectionPageState();
}

class _SelectSectionPageState extends State<SelectSectionPage> {
  final controller = Get.put(SelectSectionLogic(true));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("كل الاقسام"),
        automaticallyImplyLeading: true,
      ),
      body: Obx((){

        if(controller.loading.value){
          return const LoadingList();
        }

        return Obx((){
          return ListView.builder(itemCount: controller.list.length,itemBuilder: (context,index){
            Section section = controller.list[index];
            // bool first = customerData.id == controller.listFiltered.first.id;
            // bool last = customerData.id == controller.listFiltered.last.id;
            return ItemSection(section: section,first: false,last: false,onTap:(){
              Get.back(result: section);
            },);
          });
        });

      }),
    );
  }

  @override
  void dispose() {
    Get.delete<SelectSectionLogic>();
    super.dispose();
  }
}

