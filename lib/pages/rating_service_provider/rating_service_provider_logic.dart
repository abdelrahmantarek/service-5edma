import 'package:firebase_core/firebase_core.dart';
import 'package:fixawy_app/network/models/rating.dart';
import 'package:fixawy_app/network/models/service_provider.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/providers/WorkerProvider.dart';
import 'package:get/get.dart';



class RatingServiceProviderLogic extends GetxController with WorkerProvider{

  late ServiceProvider serviceProvider;

  @override
  void onInit() {
    serviceProvider = Get.arguments;
    super.onInit();
  }

  void sendRating(double rating, String text) async{
    Rating ratingObject = Rating(
        name: Get.find<UserData>().name!,
        image: Get.find<UserData>().image!,
        comment: text.isEmpty ? "No comment" : text, rating: rating,
        time: DateTime.now().toString()
    );


    await addRating(ratingObject, serviceProvider);

    update(["rating"]);
  }

}
