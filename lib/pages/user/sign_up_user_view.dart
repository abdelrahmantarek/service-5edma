import 'dart:ui';

import 'package:fixawy_app/CustomWidget/edit_text.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_view.dart';
import 'package:fixawy_app/shared/components/default_rounded_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'sign_up_user_logic.dart';


class SignUpUserPage extends StatefulWidget {
  static const String routeName = "/SignUpPage";
  const SignUpUserPage({Key? key}) : super(key: key);
  @override
  _SignUpUserPageState createState() => _SignUpUserPageState();
}

class _SignUpUserPageState extends State<SignUpUserPage> {
  final SignUpLogic controller = Get.put(SignUpLogic());

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text("تسجيل مستخدم"),
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
                    height: 7,
                  ),

                  const Text("قم بإنشاء حساب في خدمة للحصول على جميع الميزات",style: TextStyle(
                      color: Colors.grey
                  ),),

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
                    child: DefaultRoundedLoadingButton(
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
    Get.delete<SignUpLogic>();
    super.dispose();
  }

}