
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixawy_app/app/storage/storage.dart';
import 'package:fixawy_app/pages/main_screen/main_screen_view.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:rounded_loading_button/rounded_loading_button.dart';



class SignUpLogic extends GetxController {


  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();

  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  RxBool loading = false.obs;
  GlobalKey<FormState> form = GlobalKey();
  String userType = UserType.USER;


  Rx<File?> image = Rx<File?>(null);



  ///
  ///
  // sign up function for --------- >>>>>>>  user

  void signUp(){

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if(loading.value){
      return;
    }

    if(!form.currentState!.validate()){
      return;
    }


    loading.value = true;


    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((result)async{


      WriteBatch batch = FirebaseFirestore.instance.batch();


      Map<String,dynamic> data = {
        "image":"DEFAULT",
      };


      if(image.value != null){
        String? url = await uploadFile(image.value!);
        data["image"] = url;
      }

      data.addAll({
        "name":username.text,
        "email":email.text,
        "age":age.text,
        "address":address.text,
        "password":password.text,
        "phone":phone.text,
        "id":result.user!.uid,
        "userType":userType,
      });


      batch.set(FirebaseFirestore.instance.collection("Users").doc(result.user!.uid),data);


      batch.commit().then((value){

        loading.value=false;

        FirebaseFirestore.instance.collection("Users").where("id",isEqualTo: result.user!.uid).get().then((value) async {
          Get.find<UserData>().fromJson(value.docChanges.first.doc.data());
          await Storage.saveUser(value.docChanges.first.doc.data());
          Get.snackbar("تم", "لقد تم تسجيل مستخدم بنجاح",backgroundColor: Colors.green,colorText: Colors.white);

          btnController.success();

          await Future.delayed(Duration(seconds: 2));

          Get.offAllNamed(MainScreenPage.routeName);
        });


      }).catchError((onError){
        loading.value=false;
        Get.snackbar("error", onError.toString(),backgroundColor: Colors.red,colorText: Colors.white);
        btnController.stop();
        btnController.reset();
      });
    }).catchError((onError){
      loading.value=false;
      Get.snackbar("error", onError.toString(),backgroundColor: Colors.red,colorText: Colors.white);
      btnController.stop();
      btnController.reset();
    });

  }




  ///
  ///
  // get image from device ------------

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 75);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }



  ///
  ///
  // upload file to firebase -------------

  Future<String> uploadFile(File file) async {

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref().child('mobile').child(DateTime.now().microsecondsSinceEpoch.toString()+file.path.split("/").last);

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(file, metadata);

    return await (await uploadTask).ref.getDownloadURL();
  }




}
