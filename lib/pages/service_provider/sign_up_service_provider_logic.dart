import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixawy_app/CustomWidget/empty.dart';
import 'package:fixawy_app/app/storage/storage.dart';
import 'package:fixawy_app/pages/main_screen/main_screen_view.dart';
import 'package:fixawy_app/network/models/Region.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

class SignUpServiceProviderLogic extends GetxController {


  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController aboutService = TextEditingController();

  RxBool loading = false.obs;
  GlobalKey<FormState> form = GlobalKey();
  String userType = UserType.SERVICE_PROVIDER;

  Rx<File?> image = Rx<File?>(null);
  Rx<Section?> section = Rx<Section?>(null);
  Rx<Region?> region = Rx<Region?>(null);
  RxList<XFile> listImages = RxList<XFile>([]);
  RxList<String> timesOfWork = RxList<String>([]);

  ///
  /// String? url = await uploadFile(File(image.path));
  // sign up function for --------- >>>>>>>  user

  void signUp() {

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (loading.value) {
      return;
    }


    if (image.value == null) {
      error("برجاء تحديد صورتك الشخصية");
      return;
    }

    if (listImages.isEmpty) {
      error("برجاء تحديد بعض الصور من عملك");
      return;
    }

    if (timesOfWork.isEmpty) {
      error("برجاء تحديد اوقات عملك");
      return;
    }

    if (section.value == null) {
      error("برجاء تحديد قسم عملك اولا");
      return;
    }

    if (region.value == null) {
      error("برجاء تحديد منطقة عملك");
      return;
    }

    if (!form.currentState!.validate()) {
      return;
    }

    loading.value = true;



    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((result) async {

      WriteBatch batch = FirebaseFirestore.instance.batch();

      Map<String, dynamic> data = {
        "image": "DEFAULT",
      };


      if (image.value != null) {
        String? url = await uploadFile(image.value!);
        data["image"] = url;
      }


      if (listImages.value != null) {
        String? url = await uploadFile(image.value!);
        data["image"] = url;
      }



      List<String> availableImages = [];

      for(XFile file in listImages){
        String? url = await uploadFile(File(file.path));
        availableImages.add(url);
      }


      data.addAll({
        "name": username.text,
        "email": email.text,
        "age": age.text,
        "address": address.text,
        "password": password.text,
        "phone": phone.text,
        "aboutServiceProvider": aboutService.text,
        "id": result.user!.uid,
        "userType": userType,
        "section": section.toJson(),
        "region": region.toJson(),
        "timesOfWork": timesOfWork,
        "availableImages": availableImages,
      });

      batch.set(FirebaseFirestore.instance.collection("Users").doc(result.user!.uid), data);

      batch.commit().then((value) {
        loading.value = false;

        FirebaseFirestore.instance.collection("Users").where("id", isEqualTo: result.user!.uid).get().then((value) async {
          Get.find<UserData>().fromJson(value.docChanges.first.doc.data());
          await Storage.saveUser(value.docChanges.first.doc.data());
          Get.snackbar("تم", "لقد تم تسجيل مستخدم بنجاح", backgroundColor: Colors.green, colorText: Colors.white);
          Get.offAllNamed(MainScreenPage.routeName);
        });
      }).catchError((onError) {
        loading.value = false;
        Get.snackbar("error", onError.toString(), backgroundColor: Colors.red, colorText: Colors.white);
      });
    }).catchError((onError) {
      loading.value = false;
      Get.snackbar("error", onError.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    });


  }

  ///
  ///
  // get image from device ------------

  Future getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<List<XFile>> pickImages() async {
    List<XFile> list = [];
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage(imageQuality: 75,);
    if (selectedImages == null) {
      return [];
    }
    int index = 0;
    if (selectedImages.isNotEmpty) {
      for (XFile image in selectedImages) {
        if(index == 3){
          return list;
        }
        list.add(image);
        index++;
      }
    }
    return list;
  }

  ///
  ///
  // upload file to firebase -------------

  Future<String> uploadFile(File file) async {
    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance.ref().child('mobile').child(
        DateTime.now().microsecondsSinceEpoch.toString() +
            file.path.split("/").last);

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    UploadTask uploadTask = ref.putFile(file, metadata);

    return await (await uploadTask).ref.getDownloadURL();
  }




}
