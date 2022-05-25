

import 'package:fixawy_app/CustomWidget/edit_text.dart';
import 'package:fixawy_app/pages/sign_up/service_provider/sign_up_service_provider_view.dart';
import 'package:fixawy_app/shared/components/default_form_field.dart';
import 'package:fixawy_app/shared/components/default_rounded_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../user/sign_up_user_view.dart';
import 'sign_in_logic.dart';



class SignInPage extends StatefulWidget {
  static const String routeName = "/SignInPage";
  const SignInPage({Key? key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInLogic controller = Get.put(SignInLogic());

  @override
    Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [

            /// Positioning the widgets body in the screen.
            Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: kToolbarHeight), //32.9 ,56.0
                child: Form(
                  key: controller.form,
                  child: Column(
                    children: [
                      /// The logo of the app.
                      Image.asset(
                        "assets/images/logo.jpg",
                        fit: BoxFit.cover,
                      ),

                      SizedBox(height: size.height * 0.055), //42.6

                      DefaultFormField(
                        controller: controller.email,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {},
                        hintText: 'Email'.tr,
                        prefixIcon: Icons.email_outlined,
                        suffix: const SizedBox(width: 0),
                      ),

                      SizedBox(height: size.height * 0.034), //26.4
                      DefaultFormField(
                        controller: controller.password,
                        type: TextInputType.visiblePassword,
                        validate: (String? value) {},
                        hintText: 'Password'.tr,
                        isPassword: true,
                        prefixIcon: Icons.lock_open_rounded,
                        suffix: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.visibility_outlined),
                        ),
                      ),


                      SizedBox(height: size.height * 0.04), // 30.9

                      DefaultRoundedLoadingButton(
                        controller: controller.btnController,
                        text: 'Login'.tr,
                        onPressed:controller.signIn,
                      ),

                      SizedBox(height: size.height * 0.04), // 30.9

                      GestureDetector(
                        onTap: (){
                          Get.toNamed(SignUpServiceProviderPage.routeName);
                        },
                        child: Text(
                          'تسجيل كمقدم خدمة'
                          ,style: Theme.of(context).textTheme.subtitle1!
                            .copyWith(fontSize: 16),
                        ),
                      ),

                      SizedBox(height: size.height *  0.029), // 22

                      GestureDetector(
                        onTap: (){
                          Get.toNamed(SignUpUserPage.routeName);
                        },
                        child: Text(
                          'تسجيل ك عميل'
                          ,style: Theme.of(context).textTheme.subtitle1!
                            .copyWith(fontSize: 16),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

     return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: controller.form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: const [
                        Expanded(child: FittedBox(
                          child: Text("برنامج اخدمني",style: TextStyle(
                              color: Colors.black,
                              height: 0.80,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0
                          )),
                        ))
                      ],
                    ),
                  ),

                  Container(
                    height: 30,
                  ),

                  Text("مرحبا بك !",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      height: 0.80,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0
                  )),

                  Container(
                    height: 7,
                  ),

                  const Text("قم بتسجيل الدخول",style: TextStyle(
                      color: Colors.grey
                  ),),

                  Container(
                    height: 50,
                  ),

                  EditText(
                    controller: controller.email,
                    icon: Icons.person,
                    hint: "البريد الالكتروني",
                    validator: (text){
                      if(text!.isEmpty){
                        return "لا يمكن ان يكون فارغ";
                      }
                      return null;
                    },
                  ),

                  Container(height: 5,),

                  EditText(
                    controller: controller.password,
                    icon: Icons.lock_open,
                    hint: "كلمة المرور",
                    validator: (text){
                      if(text!.isEmpty){
                        return "لا يمكن ان يكون فارغ";
                      }
                      return null;
                    },
                  ),


                  Container(height: 20,),

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
                    child: Obx((){
                      return RaisedButton(

                        child: controller.loading.value ? const LoadingButton() :  Text("تسجيل الدخول".toUpperCase(),style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0
                        )),
                        onPressed: (){
                          controller.signIn();
                        },
                      );
                    }),
                  ),



                  const SizedBox(height: 15,),


                  Container(height: 40,),


                  GestureDetector(
                    onTap: (){

                      showModalBottomSheet(
                          context:context,
                          builder: (context){
                            return SizedBox(
                              height: 200,
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    ListTile(
                                      onTap: (){

                                      },
                                      title:const Text("تسجيل مقدم خدمة"),
                                      trailing:const Icon(Icons.check_circle_outline,color: Colors.green,),
                                    ),

                                    const Divider(),

                                    ListTile(
                                      onTap: (){

                                      },
                                      title: const Text("تسجيل مستخدم عادي"),
                                      trailing: const Icon(Icons.check_circle_outline,color: Colors.green,),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("لا تملك حساب ؟",style: TextStyle(
                            color: Colors.grey
                        ),),
                        const SizedBox(width: 5,),
                        Text("انشاء حساب جديد",style: TextStyle(
                            color: Theme.of(context).accentColor,fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                  ),

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
    Get.delete<SignInLogic>();
    super.dispose();
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 20,width: 20,
      child: const CircularProgressIndicator(
        valueColor:AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}