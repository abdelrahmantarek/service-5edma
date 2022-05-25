


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixawy_app/network/models/service_provider.dart';

class Rating{

  final String name;
  final String image;
  final String comment;
  final double rating;
  final String time;

  Rating({required this.name,required this.image,required this.comment,required this.rating,required this.time});


  factory Rating.fromJson(json){
    return Rating(name: json["name"], image: json["image"], comment: json["comment"], rating: json["rating"],time: json["time"]);
  }

  Map<String, dynamic> toRating(ServiceProvider serviceProvider) {
    return {
      "name":name,
      "image":image,
      "comment":comment,
      "rating":rating,
      "time":time,
      "provider":serviceProvider.toJson(),
      "timeStamp":FieldValue.serverTimestamp(),
    };
  }

}