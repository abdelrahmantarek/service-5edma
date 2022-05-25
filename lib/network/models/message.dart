




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;



class Message{


  late String chatRoom;
  late String fromUser;
  late String toUser;
  late String messageType;
  late dynamic _timeStamp;
  late String messageKey;
  late String messageText;


  Message.fromJson(Map<String,dynamic> data){
    chatRoom = data["reservationId"];
    fromUser = data["fromUser"].toString();
    toUser = data["toUser"].toString();
    messageKey = data["messageKey"];
    _timeStamp = data["timeStamp"];
    _timeStamp ??= DateTime.now();
    messageType = data["messageType"];
    messageText = data["messageText"];
  }


  getTime(){
    if(_timeStamp is DateTime){
      return timeago.format(_timeStamp);
    }
    return timeago.format(_timeStamp.toDate());
  }

  bool get isMe{
    return fromUser.toString() == Get.find<UserData>().id.toString();
  }

  bool get isOther{
    return fromUser.toString() != Get.find<UserData>().id.toString();
  }


}