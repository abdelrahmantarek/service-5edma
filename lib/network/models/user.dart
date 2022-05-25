


import 'package:fixawy_app/network/models/Region.dart';
import 'package:fixawy_app/network/models/section.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:get/get.dart';


class UserData extends GetxController{



  Region? region;
  String? address;
  List<dynamic>? timesOfWork;
  List<dynamic>? availableImages;
  String? email;
  String? image;
  String? name;
  String? password;
  String? aboutServiceProvider;
  String? phone;
  String? age;
  String? id;
  String? userType;
  Section? section;


  RxBool isNull = true.obs;



  UserData();

  UserData.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }


  fromJson(json){

    isNull.value = json == null;

    if(isNull.value){
      refresh();
      return;
    }

    id = json['id'];
    userType = json['userType'];
    address = json['address'];
    image = json['image'];
    timesOfWork = json['timesOfWork'];
    availableImages = json['availableImages'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    aboutServiceProvider = json['aboutServiceProvider'];

    if(json['section']!=null){
      section = Section.fromJson(json['section']);
    }

    if(json['region']!=null){
      region = Region.fromJson(json['region']);
    }

  }


  UserData.Default() {
    id = "id";
    address = "el zaher - cairo";
    timesOfWork = [];
    availableImages = [];
    email = "ahmed@yahoo.com";
    name = "Ahmed saber";
    password = "12341234";
    phone = "01553158154";
    aboutServiceProvider = "about";
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['address'] = address;
    data['timesOfWork'] = timesOfWork;
    data['availableImages'] = availableImages;
    data['email'] = email;
    data['name'] = name;
    data['userType'] = userType;
    data['password'] = password;
    data['phone'] = phone;
    data['aboutServiceProvider'] = aboutServiceProvider;
    if(section!=null){
      data['section'] = section!.toJson();
    }
    if(region!=null){
      data['region'] = region!.toJson();
    }
    return data;
  }



}