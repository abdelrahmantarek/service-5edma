import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:fixawy_app/pages/profile_service_provider/profile_service_provider_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';

import '../rating_add/rating_add_view.dart';
import '../rating_service_provider/rating_service_provider_view.dart';




class ProfileServiceProviderPage extends StatefulWidget {
  static const String routeName = "/ProfileServiceProviderPage";
  final ServiceProvider? serviceProvider;
  final Section? section;
  const ProfileServiceProviderPage({Key? key, this.serviceProvider, this.section}) : super(key: key);
  @override
  _ProfileServiceProviderPageState createState() => _ProfileServiceProviderPageState();
}

class _ProfileServiceProviderPageState extends State<ProfileServiceProviderPage> {
  late ProfileServiceProviderLogic controller;
  @override
  void initState() {
    controller = Get.put(ProfileServiceProviderLogic(
      section: widget.section,
      serviceProvider: widget.serviceProvider
    ));
    super.initState();
  }
  @override
    Widget build(BuildContext context) {

    Radius radius = const Radius.elliptical(9999.0, 2222.0);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "شخصي"
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(child: Image.network(controller.serviceProvider!.image!,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,height: MediaQuery.of(context).size.longestSide * 40 / 100,errorBuilder: (c,q,w){
            return Image.asset("assets/images/DR-avatar.png");
          },),
            right: 0,left: 0,top: 0,),

          Positioned(child: Container(
            height: MediaQuery.of(context).size.longestSide * 50 / 100,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.only(topLeft: radius,topRight: radius),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xde000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(controller.serviceProvider!.name!,style: context.theme.textTheme.headline5,textAlign: TextAlign.center,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.serviceProvider!.email!,
                      style: context.theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    Text(controller.serviceProvider!.phone!,
                      style: context.theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),

                const Divider(height: 50,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("قسم",style: context.theme.textTheme.headline5,textAlign: TextAlign.center,),
                          Text(controller.serviceProvider!.section!.nameSection!,
                            style: context.theme.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("مكان العمل",style: context.theme.textTheme.headline5,textAlign: TextAlign.center,),
                          Text(controller.serviceProvider!.address!,
                            style: context.theme.textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.toNamed(RatingServiceProviderPage.routeName,arguments: Get.find<ProfileServiceProviderLogic>().serviceProvider);
                            },
                            child: Center(
                              child: Text("تقيماتي",
                                style: context.theme.textTheme.headline5,
                                textAlign: TextAlign.center,
                              )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

                const Divider(height: 50,),

                Visibility(
                  visible: Get.find<UserData>().userType == UserType.USER,
                  child: Container(
                      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).orientation == Orientation.landscape ? 50 : 20.0,right: 20,left: 20,top: 5),
                      child:SafeArea(
                        top: false,right: false,left: false,
                        child: SingleChildScrollView(
                          child: Row(
                            children: [

                              Expanded(child: SizedBox(
                                height: 50,
                                width: context.width,
                                child:Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 3,child: CustomButton1(
                                      color: Theme.of(context).accentColor,
                                      onTap: (){
                                        controller.book();
                                      },
                                      iconData: Icons.alarm,
                                      text: "حجز الان",
                                    )),
                                  ],
                                ),
                              )),

                              SizedBox(width: 10,),

                              Expanded(child: SizedBox(
                                height: 50,
                                width: context.width,
                                child:Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(flex: 3,child: CustomButton1(
                                      color: Colors.redAccent,
                                      onTap: (){
                                        controller.book();
                                      },
                                      iconData: Icons.account_tree,
                                      text: "عمل شكوى",
                                    )),
                                  ],
                                ),
                              ))

                            ],
                          ),
                        ),
                      )
                  ),
                ),

              ],
            ),
          ),
            right: -10,left: -10,bottom: -20,)
        ],
      ),


      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.call),
      //   onPressed: (){
      //     launch("tel://" + doctor.phone!);
      //   },
      // ),
    );


    return Scaffold(
      appBar: AppBar(

      ),
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: [


            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                   ProfileHeader(name: controller.serviceProvider!.name!, region: controller.serviceProvider!.region!.name!, image: controller.serviceProvider!.image!,),

                  Container(
                    margin: const EdgeInsets.only(right: 15, left: 15, top: 10,),
                    child: Text(
                      "جميع اعمال السابقة",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "SquadaOne", fontSize: 12.sp, color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ),

                  CollectionsList(images: controller.serviceProvider!.availableImages!,),

                  const Divider(),


                  ListTile(
                    title: Text("اوقات عملي",style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),),
                    subtitle:Column(
                      children: controller.serviceProvider!.timesOfWork!.map((e) => ListTile(
                        title: Text(e.toString(),style: TextStyle(
                          fontWeight: FontWeight.normal
                        ),),
                      )).toList(),
                    ),
                  ),

                  const Divider(),

                  Visibility(
                    visible: Get.find<UserData>().userType == UserType.USER,
                    child: Container(
                      height: 100,
                      child: Column(
                        children: [
                          Container(
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: RoundedLoadingButton(
                                controller: RoundedLoadingButtonController(),
                                height: 35,
                                width: Get.width,
                                borderRadius: 10,
                                onPressed: () async{

                                },
                                animateOnTap: false,
                                color: Get.theme.accentColor,
                                child: Text(
                                  "حجز الان",
                                  style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.white),
                                )),
                          ),

                          const SizedBox(height: 10,),

                          Container(
                            width: Get.width,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                  style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.white),
                                )),
                          )

                        ],
                      ),
                    ),
                  ),

                  Container(height: 100,),

                ],
              ),
            ),



          ],
        ),
      ),
    );
    }

  @override
  void dispose() {
    Get.delete<ProfileServiceProviderLogic>();
    super.dispose();
  }
}


class ProfileHeader extends StatelessWidget {
  final String name;
  final String region;
  final String image;
  const ProfileHeader({Key? key,required this.name,required this.region,required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        color: Colors.white.withOpacity(0.9),
        child: Container(
          padding: const EdgeInsets.only(
              top: 15, right: 15, left: 15, bottom: 15),
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(image),
                          radius: 80
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontFamily: "SquadaOne",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "انا اعمل في : ${region}",
                            style: TextStyle(
                                fontSize: 9.sp,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold),
                          ),

                        ],
                      )
                    ],
                  )),

              const SizedBox(height: 10,),

              Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: (){
                    Get.toNamed(RatingServiceProviderPage.routeName,arguments: Get.find<ProfileServiceProviderLogic>().serviceProvider);
                  },
                  child: Center(
                    child: Text(
                      "روية جميع تقيماتي لطلبي عند الخدمة",
                      style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.black),
                    ),
                  ),
                )
              ),

            ],
          ),
        ));
  }
}




class CollectionsList extends StatelessWidget {
  final List<dynamic> images;
  const CollectionsList({Key? key,required this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final double itemHeight = (size.longestSide - kToolbarHeight - 24) / 2;
    final double itemWidth = size.longestSide * 0.40;

    return GridView.count(
      crossAxisSpacing: 15,
      mainAxisSpacing: 16,
      crossAxisCount: 3,
      padding: EdgeInsets.symmetric(
          vertical: 15, horizontal: size.width * 0.05),
      childAspectRatio: (itemWidth / itemHeight + 0.1),
      controller: ScrollController(keepScrollOffset: false),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: images.map((e){
        return ItemCollection(
          image: e.toString(),
        );
      }).toList(),
    );

    return Container(
        height: 240,
        width: Get.width,
        margin: const EdgeInsets.only(left: 0, top: 10),
        child: ListView.builder(
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c,index){
            return Container(
              margin: const EdgeInsets.only(left: 5),
              child: ItemCollection(
                image: images[index].toString(),
              ),
            );
          },
        ));
  }
}




class ItemCollection extends StatelessWidget {
  final String image;
  const ItemCollection({Key? key,required this.image,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5,top: 5,bottom: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.9),
              blurRadius: 3.0,
              spreadRadius: 0.0,
              offset: const Offset(0.0, 2.0)),
        ],
        shape: BoxShape.rectangle,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
