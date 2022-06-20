
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/app/storage/storage.dart';
import 'package:fixawy_app/pages/main_screen/main_screen_view.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';



class SignInLogic extends GetxController {


  RxBool loading = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> form = GlobalKey();
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();


  bool value =false;

  signIn()async{

    SystemChannels.textInput.invokeMethod('TextInput.hide');


    if(loading.value){
      return;
    }

    if(!form.currentState!.validate()){
      return;
    }

    loading.value = true;

    btnController.start();

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value){
      loading.value=false;

      FirebaseFirestore.instance.collection("Users").where("email",isEqualTo: email.text).get().then((value) async {

        // result -------- success

        Get.find<UserData>().fromJson(value.docChanges.first.doc.data());
        await Storage.saveUser(value.docChanges.first.doc.data());
        var da = await Storage.userExist();


        btnController.success();

        await Future.delayed(const Duration(seconds: 2));

        success("لقد تم تسجيل الدخول بنجاح");

        Get.offAndToNamed(MainScreenPage.routeName);

      }).catchError((onError){
        // result -------- error
        loading.value=false;
        error(onError.toString());
        btnController.stop();
        btnController.reset();
      });

    }).catchError((onError){

      // result -------- error
      btnController.stop();
      btnController.reset();
      loading.value=false;
      error(onError.toString());
    });


  }

  static logOutPop(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("لا"),
      onPressed:  () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("نعم"),
      onPressed:  () async{
        await Storage.removeUser();
        Get.find<UserData>().fromJson(null);
        Get.offAllNamed(SignInPage.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تسجيل الخروج"),
      content: Text("هل تريد تسجيل الخروج ؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
