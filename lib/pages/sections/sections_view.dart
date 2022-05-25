import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/pages/service_providers/service_providers_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sections_logic.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';




class SectionsPage extends GetView<SectionsLogic> {
  const SectionsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.longestSide - kToolbarHeight - 24) / 2;
    double itemWidth = size.longestSide * 0.40;



    return Obx((){

      if(controller.loading.value){
         return LoadingList();
      }

      return Obx((){
        return Refresh(
          child: !controller.loading.value  && controller.list.isEmpty ? const EmptyList(

            text: "فارغ",
          ) : true ? GridView.count(
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            crossAxisCount: 2,
            padding: EdgeInsets.symmetric(
                vertical: 15, horizontal: size.width * 0.05),
            childAspectRatio: (itemWidth / itemHeight),
            controller: ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: controller.list.map((section) {
              return ItemSection(section: section,first: false,last: false,onTap:() async {
                Get.toNamed(ServiceProvidersPage.routeName,arguments: section);
              },);
            }).toList(),
          ) : ListView.builder(itemCount: controller.list.length,itemBuilder: (context,index){
            Section section = controller.list[index];
            // bool first = customerData.id == controller.listFiltered.first.id;
            // bool last = customerData.id == controller.listFiltered.last.id;
            return ItemSection(section: section,first: false,last: false,onTap:() async {
              Get.toNamed(ServiceProvidersPage.routeName,arguments: section);
            },);
          }),
        );
      });

    });
  }
}


class Refresh extends GetView<SectionsLogic> {
  final Widget? child;
  const Refresh({Key? key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(
        waterDropColor: Get.theme.primaryColor,
      ),
      footer: CustomFooter(
        height: 250,
        builder: (BuildContext context,LoadStatus? mode){
          return const SizedBox(
            height: 55.0,
            child: Center(),
          );
        },
      ),
      controller: controller.refreshController!,
      onRefresh: controller.refresh,
      // onLoading: controller.onLoadingRefresh,
      child:child,
    );
  }
}


class ItemSection extends GetView<SectionsLogic> {
  final Section? section;
  final bool? first;
  final bool? last;
  final GestureTapCallback? onTap;
  const ItemSection({Key? key, this.section,this.onTap, this.first, this.last}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
      // height: size.height * 0.22,
      // width: size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: InkWell(
        onTap:onTap,
        borderRadius: BorderRadius.circular(20),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(100),
                  child: Image.network(section!.image!,fit: BoxFit.cover,),
                ),
                //10.2
                Text(section!.nameSection!,
                    style: Theme.of(context).textTheme.headline5!
                        .copyWith(fontSize: 70)),
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: first! ? 30 : 0,bottom: last! ? 50 : 0),
          child: ListTile(
            minVerticalPadding: 10,
            contentPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            onTap: onTap,
            leading: Image.network(section!.image!,width: 40,),
            title: Text(section!.nameSection.toString()),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
        const Divider(height: 0.3,),
      ],
    );

  }
}

