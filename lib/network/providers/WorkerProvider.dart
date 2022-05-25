


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/Complain.dart';
import 'package:fixawy_app/network/models/rating.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/providers/UserProvider.dart';
import 'package:get/get.dart';

class WorkerProvider{

  Future<void> makeComplainByWorker(ServiceProvider serviceProvider,String theComplain)async{
    await FirebaseFirestore.instance.collection("complains").add({
      "user":Get.find<UserData>().toJson(),
      "provider":serviceProvider.toJson(),
      "theComplain":theComplain,
      "time":DateTime.now().toString(),
      "timeStamp":FieldValue.serverTimestamp()
    });
    return;
  }

  Future<List<Complain>> getAllComplains()async{
    return await FirebaseFirestore.instance.collection("complains").orderBy("timeStamp",descending: true).get().then((value) => value.docChanges.map((e) => Complain.fromJson(e.doc.data()!,e.doc.id)).toList());
  }

  Future<void> replyOnComplain(Complain complain, String reply) async{
    await FirebaseFirestore.instance.collection("complains").doc(complain.id).update(
      complain.toReply(reply)
    );
    return;
  }

  Future<List<Rating>> getRatingUserProvider(ServiceProvider user) async{
    return await FirebaseFirestore.instance.collection("ratings").where("provider.email",isEqualTo: user.email).orderBy("timeStamp",descending: true).get().then((value) => value.docChanges.map((e) => Rating.fromJson(e.doc.data()!)).toList());
  }

  Future<void> addRating(Rating ratingObject,ServiceProvider serviceProvider) async{
     await FirebaseFirestore.instance.collection("ratings").add(ratingObject.toRating(serviceProvider));
     return;
  }

}