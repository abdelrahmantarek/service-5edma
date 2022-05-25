


import 'package:equatable/equatable.dart';

class Section{

  String? id;
  String? nameSection;
  String? image;

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameSection = json['name'];
    image = json['image'];
  }

  Section.Default() {
    id = "1";
    nameSection = "name Section";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = nameSection;
    data['image'] = image;
    return data;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;

  @override
  bool operator ==(dynamic other) {
    // TODO: implement ==
    return other.id == id;
  }

}