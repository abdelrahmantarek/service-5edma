

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/message.dart';
import 'package:fixawy_app/network/models/reservation.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';




class ChatLogic extends GetxController {


  StreamController<Message> streamMessageController = StreamController<Message>.broadcast();
  StreamSubscription<QuerySnapshot>? stream;
  List<String> messageKey = [];
  RxList<Message> listMessages = RxList<Message>([]);
  TextEditingController textEditingController = TextEditingController();
  int limit = 100;
  RxBool firstLoad = false.obs;

  String reservationId = "take it from first page";
  late Reservation reservation;

  listenToChat(){

    stream = FirebaseFirestore.instance.collection("Chat")
        .orderBy("timeStamp", descending: true)
        .where("reservationId",isEqualTo: reservationId)
        .limit(limit).snapshots().listen((event) {



      if(event.docChanges.isEmpty){
        firstLoad.value = true;
        return;
      }

      if(firstLoad.value){

        onNewMessage(event);

      }else{

        firstLoadMessages(event);

      }

    });
  }


  void onNewMessage(QuerySnapshot event) {
    for(DocumentChange doc in event.docChanges){
      Message message =  Message.fromJson(doc.doc.data()!);
      if(!messageKey.contains(message.messageKey.toString()) && doc.type == DocumentChangeType.added){
        messageKey.add(message.messageKey.toString());
        listMessages.insert(0,message);
      }
    }
  }


  void firstLoadMessages(QuerySnapshot event) {
    for(DocumentChange doc in event.docChanges){
      Message message =  Message.fromJson(doc.doc.data()!);
      listMessages.add(message);
      messageKey.add(message.messageKey.toString());
    }
    firstLoad.value = true;
  }



  sendText() async {

    if (textEditingController.text.isNotEmpty) {

      String messageKey = FirebaseFirestore.instance.collection("Chat").doc().id;

      Map<String,dynamic> message = {
        "fromUser":Get.find<UserData>().id.toString(),
        "messageKey":messageKey,
        "messageType":"TEXT",
        "reservationId":reservationId,
        "messageText":textEditingController.text,
        "timeStamp":FieldValue.serverTimestamp(),
      };

      textEditingController.text = "";
      await FirebaseFirestore.instance.collection("Chat").doc(messageKey).set(message).then((f) {});

    }

  }



  @override
  void dispose() {
    stream?.cancel();
    super.dispose();
  }


  @override
  void onInit() {
    reservation = Get.arguments;
    reservationId = reservation.reservationId!;
    listenToChat();
    super.onInit();
  }

}
