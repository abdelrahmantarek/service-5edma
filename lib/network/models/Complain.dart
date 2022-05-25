import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';

class Complain {
  UserData? user;
  ServiceProvider? serviceProvider;
  String? theComplain;
  String? time;
  String? reply;
  late String id;

  Complain({this.user, this.serviceProvider, this.theComplain, this.time});

  Complain.fromJson(Map<String, dynamic> json,String id) {
    user = UserData.fromJson(json['user']);
    serviceProvider = ServiceProvider.fromJson(json['provider']);
    theComplain = json['theComplain'];
    time = json['time'];
    reply = json['reply'];
    this.id = id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.user!.toJson();
    data['serviceProviderId'] = this.serviceProvider!.toJson();
    data['theComplain'] = this.theComplain;
    data['time'] = this.time;
    data['id'] = this.id;
    data['reply'] = this.reply;
    return data;
  }

  Map<String, dynamic> toReply(String reply) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.user!.toJson();
    data['serviceProviderId'] = this.serviceProvider!.toJson();
    data['theComplain'] = this.theComplain;
    data['time'] = this.time;
    data['id'] = this.id;
    data['reply'] = reply;
    return data;
  }
}