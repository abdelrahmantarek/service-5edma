

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:get/get.dart';

import '../models/Complain.dart';



class UsersProviders{


  Future<Map<String,dynamic>?> signIn(String email,String password)async{
    return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async => await getUserById(value.user!.uid));
  }

  Future<bool> userExist(String email)async{
    try{
      var data = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: DateTime.now().microsecondsSinceEpoch.toString());
      if(data.user != null){
        FirebaseAuth.instance.signOut();
        return true;
      }
      return false;
    }on FirebaseAuthException catch(err){
      if(err.code == "wrong-password"){
        return true;
      }
      return false;
    }catch(err){
      return false;
    }
  }

  Future<Map<String,dynamic>?> signUp(String email,String password,Map<String,dynamic> body)async{
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((userData) async => await insertUser(body,userData.user!.uid)
        .then((value) async => await getUserById(userData.user!.uid))
    );
  }

  Future<DocumentReference> insertUser(Map<String,dynamic> data,String userId)async{
    data["Id"] = userId;
    return await FirebaseFirestore.instance.collection("users").add(data);
  }



  Future<Map<String,dynamic>?> getUserById(String uid)async{
    return await FirebaseFirestore.instance.collection("users").where("Id",isEqualTo:uid).get().then((value) => value.docChanges.first.doc.data());
  }


  Future<String> uploadFile(File file) async {
    Reference ref = FirebaseStorage.instance.ref().child('mobile').child(DateTime.now().microsecondsSinceEpoch.toString() + file.path.split("/").last);
    final metadata = SettableMetadata(contentType: 'image/jpeg', customMetadata: {'picked-file-path': file.path});
    UploadTask uploadTask = ref.putFile(file, metadata);
    return await (await uploadTask).ref.getDownloadURL();
  }

  
  Future<List<Complain>> getMyComplain()async{
    return await FirebaseFirestore.instance.collection("complains").orderBy("timeStamp",descending: true).where("user.email",isEqualTo: Get.find<UserData>().email).get().then((value) => value.docChanges.map((e) => Complain.fromJson(e.doc.data()!,e.doc.id)).toList());
  }


}