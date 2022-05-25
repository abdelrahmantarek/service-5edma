import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/pages/book_now/book_now_view.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/shared/components/Avatar1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../profile_service_provider/profile_service_provider_view.dart';
import 'service_providers_logic.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';



class ServiceProvidersPage extends StatefulWidget {
  static const String routeName = "/ServiceProvidersPage";
  const ServiceProvidersPage({Key? key}) : super(key: key);
  @override
  _ServiceProvidersPageState createState() => _ServiceProvidersPageState();
}

class _ServiceProvidersPageState extends State<ServiceProvidersPage> {
  final ServiceProvidersLogic controller = Get.put(ServiceProvidersLogic());

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("${controller.section!.nameSection}".capitalize!),
        ),
        body: Obx((){
          return !controller.loading.value  && controller.list.isEmpty ? const EmptyList(
              text: "فارغ",
            ) : ListView.builder(itemCount: controller.list.length,itemBuilder: (context,index){
              ServiceProvider serviceProvider = controller.list[index];
              // bool first = customerData.id == controller.listFiltered.first.id;
              // bool last = customerData.id == controller.listFiltered.last.id;
              return ItemServiceProvider(serviceProvider: serviceProvider,);
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: false ? 30 : 0,bottom: false ? 50 : 0),
                    child: ListTile(
                      minVerticalPadding: 10,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                      onTap: ()async{
                        Get.toNamed(ProfileServiceProviderPage.routeName,arguments: {
                          "serviceProvider":serviceProvider,
                          "section":controller.section
                        });
                      },
                      leading: Image.network(serviceProvider.image!,width: 60,),
                      title: Text(serviceProvider.name!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("المنطقة : " + serviceProvider.region!.name.toString()),
                          Text("الهاتف : " + serviceProvider.phone.toString()),
                          Text("العنوان : " + serviceProvider.address.toString()),
                          const SizedBox(height: 15,),
                          RoundedLoadingButton(
                              controller: RoundedLoadingButtonController(),
                              height: 35,
                              borderRadius: 10,
                              onPressed: () async{
                                Get.toNamed(BookNowPage.routeName,arguments: {
                                  "serviceProvider":serviceProvider,
                                  "section":controller.section
                                });
                              },
                              animateOnTap: false,
                              color: Get.theme.accentColor,
                              child: Text(
                                "حجز",
                                style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.white),
                              )),
                          const SizedBox(height: 5,),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(height: 0.3,),
                ],
              );
            });
        }),
      );
    }

  @override
  void dispose() {
    Get.delete<ServiceProvidersLogic>();
    super.dispose();
  }
}

class ItemServiceProvider extends GetView<ServiceProvidersLogic> {
  final ServiceProvider serviceProvider;
  const ItemServiceProvider({Key? key,required this.serviceProvider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.amberAccent.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap:(){

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 10,),
                    Flexible(child: Text(
                      serviceProvider.region!.name.toString(),
                      style:Get.textTheme.subtitle1,
                      maxLines: 8,
                    )),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.call),
                    SizedBox(width: 10,),
                    Flexible(child: Text(
                      serviceProvider.phone.toString(),
                      style:Get.textTheme.subtitle1,
                      maxLines: 8,
                    )),
                  ],
                ),

                const SizedBox(height: 20,),

                Text('Estimated price for this trip : ${serviceProvider.name} LE', style: Get.textTheme.bodySmall!.copyWith(color: Colors.green,height: 1.2)),

                const SizedBox(height: 5,),

                Divider(height: 30,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Avatar(image: serviceProvider.image!),
                        const SizedBox(width: 5,),
                        Text(serviceProvider.name!, style: Get.textTheme.bodySmall,)
                      ],
                    ),
                    RaisedButton(onPressed: (){
                      Get.toNamed(ProfileServiceProviderPage.routeName,arguments: {
                        "serviceProvider":serviceProvider,
                        "section":controller.section
                      });
                    },
                      elevation: 0.2,
                      color: const Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'حجز مع ${serviceProvider.name}',
                        style: TextStyle(
                          fontFamily: '.AppleSystemUIFont',
                          color: Color(0xff161616),
                          fontWeight: FontWeight.w500,
                        ),
                      ),),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
