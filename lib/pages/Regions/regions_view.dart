import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/network/models/Region.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'regions_logic.dart';

class RegionsPage extends StatefulWidget {
  static const String routeName = "/RegionsPage";
  const RegionsPage({Key? key}) : super(key: key);
  @override
  _RegionsPageState createState() => _RegionsPageState();
}

class _RegionsPageState extends State<RegionsPage> {
  final controller = Get.put(RegionsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    Get.delete<RegionsLogic>();
    super.dispose();
  }
}

class ItemRegion extends StatelessWidget {
  final Region? region;
  final bool? first;
  final bool? last;
  final GestureTapCallback? onTap;
  const ItemRegion({Key? key, this.region,this.onTap, this.first, this.last}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: first! ? 30 : 0,bottom: last! ? 50 : 0),
          child: ListTile(
            minVerticalPadding: 10,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            onTap: onTap,
            leading: const Icon(Icons.add_location),
            title: Text(region!.name.toString()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
        const Divider(height: 0.3,),
      ],
    );
  }
}
