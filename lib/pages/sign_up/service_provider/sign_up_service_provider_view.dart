

import 'dart:io';
import 'package:fixawy_app/CustomWidget/edit_text.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/select_regions/select_region_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/select_section/select_section_view.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/select_times/select_times_view.dart';
import 'package:fixawy_app/shared/components/default_rounded_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'sign_up_service_provider_logic.dart';



class SignUpServiceProviderPage extends StatefulWidget {
  static const String routeName = "/SignUpServiceProviderPage";
  const SignUpServiceProviderPage({Key? key}) : super(key: key);
  @override
  _SignUpServiceProviderPageState createState() => _SignUpServiceProviderPageState();
}

class _SignUpServiceProviderPageState extends State<SignUpServiceProviderPage> {
  final controller = Get.put(SignUpServiceProviderLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text("تسجيل مقدم الخدمة"),
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Icon(Icons.arrow_back,color: Colors.black,),
          ),
        ),
      ),
      body:Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key:controller.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(height: 30,),



                  Text("التسجيل",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      height: 0.80,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0
                  )),



                  Container(
                    height: 50,
                  ),

                  GestureDetector(
                    onTap: (){
                      controller.getImage();
                    },
                    child: Obx((){
                      return CircleAvatar(backgroundColor: Colors.white, backgroundImage: controller.image.value == null ? Image.asset("assets/images/user.png").image : Image.file(controller.image.value!).image, radius: 70,);
                    }),
                  ),

                  Container(height: 30,),


                  const Text("بعض الصور من اعمالك السابقة",style: TextStyle(
                      color: Colors.grey
                  ),),

                  Container(height: 30,),

                  // add widget

                  Obx((){

                    if(controller.listImages.isEmpty){
                      return GestureDetector(
                        onTap: ()async{
                          controller.listImages.value = await controller.pickImages();
                        },
                        child: SizedBox(
                          height: 100,
                          child:Icon(
                            Icons.camera,
                            size: 70,
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: ()async{
                        controller.listImages.value = await controller.pickImages();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child:SizedBox(
                          child: GridView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 120,
                                  mainAxisExtent: 40,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 12 ),
                              itemCount: controller.listImages.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Image.file(File(controller.listImages[index].path));
                              }),
                        ),
                      ),
                    );
                  }),

                  Container(height: 30,),

                  ListTile(
                    title: const Text("اوقات عملك"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [


                        Obx((){
                          return Column(
                            children: controller.timesOfWork.map((element) => Text(element)).toList(),
                          );
                        }),

                        InkWell(
                          onTap: ()async{
                            dynamic timesOfWork = await Get.toNamed(SelectTimesPage.routeName);
                            if(timesOfWork != null){
                              controller.timesOfWork.value = timesOfWork;
                            }
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [


                              Text("اضافة"),
                              Icon(Icons.add,color: Colors.green,),


                            ],
                          ),
                        )

                      ],
                    ),
                  ),

                  Container(height: 30,),

                  Obx((){
                    return ListTile(
                      title: const Text("ما هو قسم عملك"),
                      subtitle: controller.section.value != null ? Text(controller.section.value!.nameSection!) : const Text("لم يتم التحديد"),
                      onTap: ()async{
                        dynamic section = await Get.toNamed(SelectSectionPage.routeName);
                        if(section != null){
                          controller.section.value = section;
                        }
                      },
                    );
                  }),

                  Container(height: 30,),

                  Obx((){
                    return ListTile(
                      title: const Text("اختر منطقة عملك"),
                      subtitle: controller.region.value != null ? Text(controller.region.value!.name!) : const Text("لم يتم التحديد"),
                      onTap: ()async{
                        dynamic region = await Get.toNamed(SelectRegionsPage.routeName);
                        if(region != null){
                          controller.region.value = region;
                        }
                      },
                    );
                  }),


                  Container(
                    height: 50,
                  ),


                  EditText(
                    controller: controller.username,
                    icon: Icons.person,
                    hint: "الاسم",
                    label: "jhone Williames",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.email,
                    icon: Icons.email,
                    hint: "البريد الالكتروني",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.phone,
                    icon: Icons.phone_android_rounded,
                    hint: "رقم الهاتف",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.age,
                    icon: Icons.contact_page_outlined,
                    hint: "السن",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.address,
                    icon: Icons.home,
                    hint: "العنوان",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.password,
                    icon: Icons.lock_open,
                    hint: "كلمة المرور",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.aboutService,
                    icon: Icons.list_alt,
                    hint: "بعض الاضافات المختصرة عن عملك",
                    validator: (text) => text!.isEmpty ? "لا يجب ان يكون فارغ" : null,
                  ),


                  Container(height: 40,),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).buttonColor.withOpacity(0.4),
                              offset: const Offset(0.0,5.5),
                              blurRadius: 10
                          )
                        ]
                    ),
                    width: MediaQuery.of(context).size.width * 50 / 100,
                    child:  DefaultRoundedLoadingButton(
                      controller: controller.btnController,
                      text: 'تسجيل',
                      onPressed:controller.signUp,
                    ),
                  ),

                  const SizedBox(height: 50,),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("انا معي حساب  !",style: TextStyle(
                          color: Colors.grey
                      ),),
                      const SizedBox(width: 5,),
                      Text("الرجوع لتسجيل الدخول",style: TextStyle(
                          color: Theme.of(context).accentColor,fontWeight: FontWeight.w600
                      ),)
                    ],
                  ),

                  Container(height: 30,),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SignUpServiceProviderLogic>();
    super.dispose();
  }
}