


import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';


class PaymentData{

  String? cardCvv;
  String? cardName;
  String? cardNumber;

  PaymentData.fromJson(Map<String, dynamic> json) {
    cardCvv = json['cardCvv'];
    cardName = json['cardName'];
    cardNumber = json['cardNumber'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardCvv'] = cardCvv;
    data['cardName'] = cardName;
    data['cardNumber'] = cardNumber;
    return data;
  }
}


class Reservation {


  PaymentData? paymentData;
  String? notes;
  String? reservationId;
  dynamic serviceExecutionDate;
  String? paymentStatus;
  String? paymentMethod;

  ServiceProvider? serviceProvider;
  Section? section;
  UserData? user;



  Reservation.fromJson(Map<String, dynamic> json) {
    notes = json['notes'];
    reservationId = json['reservationId'];
    serviceExecutionDate = json['serviceExecutionDate'];
    paymentStatus = json['paymentStatus'];
    paymentMethod = json['paymentMethod'];
    if(json['section']!=null){
       section = Section.fromJson(json['section']);
    }
    if(json['paymentData']!=null){
      paymentData = PaymentData.fromJson(json['paymentData']);
    }
    if(json['serviceProvider']!=null){
      serviceProvider = ServiceProvider.fromJson(json['serviceProvider']);
    }
    if(json['user']!=null){
      user = UserData.fromJson(json['user']);
    }

  }

  Reservation.Default() {
    reservationId = "1";
    serviceExecutionDate = "25-10-2021 08:33 pm";
    paymentStatus = "Pending";
    paymentMethod = "Cash";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notes'] = notes;
    data['reservationId'] = reservationId;
    data['serviceExecutionDate'] = serviceExecutionDate;
    data['paymentStatus'] = paymentStatus;
    data['paymentMethod'] = paymentMethod;
    if(section!=null){
      data['section'] = section!.toJson();
    }
    if(serviceProvider!=null){
      data['serviceProvider'] = serviceProvider!.toJson();
    }
    if(paymentData!=null){
      data['paymentData'] = paymentData!.toJson();
    }

    if(user!=null){
      data['user'] = user!.toJson();
    }

    return data;
  }

}
