import 'package:fixawy_app/extensions/StyleV.dart';
import 'package:fixawy_app/network/models/rating.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:fixawy_app/pages/rating_add/rating_add_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'rating_service_provider_logic.dart';

class RatingServiceProviderPage extends StatefulWidget {
  static const String routeName = "/RatingServiceProviderPage";
  const RatingServiceProviderPage({Key? key}) : super(key: key);
  @override
  _RatingServiceProviderPageState createState() => _RatingServiceProviderPageState();
}

class _RatingServiceProviderPageState extends State<RatingServiceProviderPage> {
  final controller = Get.put(RatingServiceProviderLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جميع تقيمات"),
      ),
      body: GetBuilder<RatingServiceProviderLogic>(
        id: "rating",
        builder: (controller){
          return FutureBuilder<List<Rating>>(
            future: controller.getRatingUserProvider(controller.serviceProvider),
            builder: (context,snapShot){

              if(snapShot.data == null){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<Rating> list = snapShot.data!;


              if(list.isEmpty){
                return const Center(
                  child:Text("No Rating found")
                );
              }

              return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemBuilder: (context,index){
                    Rating rating = list[index];
                    return ItemReview(rating: rating);
                  },
                  separatorBuilder: (context,index){
                    return const Divider(height: 20,);
                  },
                  itemCount: list.length
              );

            },
          );
        },
      ),
      bottomNavigationBar: Visibility(
        visible: Get.find<UserData>().userType == UserType.USER,
        child: SizedBox(
          height: 50,
          child:RaisedButton(
            onPressed: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return const RatingAddPage();
                  }
              );
            },
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child:Text("اضافة تقيم",style: TextStyle(
                color: Colors.green
            ),),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<RatingServiceProviderLogic>();
    super.dispose();
  }

}

/*

 */


class ItemReview extends StatelessWidget {
  final Rating rating;
  const ItemReview({Key? key,required this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      color: context.theme.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ExpandWidget(children: [
            Text(rating.name,style: context.title3,),

            ExpandWidget(
              children: [
                Text(rating.time.toString())
              ],
            ),

          ],),

          const SizedBox(height: 10,),

          ExpandWidget(children: [
            Text("التقيم",style: context.subtitle1,),
            ExpandWidget(
              children: [
                SmallRate(
                  rate: rating.rating,
                ),
                const SizedBox(width: 5,),
                Text("( ${rating.rating.toString()} )")
              ],
            ),
          ],),

          Text(rating.comment.toString()),

          const SizedBox(height: 10,),

        ],
      ),
    );
  }
}

class ExpandWidget extends StatelessWidget {
  final List<Widget>? children;
  const ExpandWidget({Key? key,required this.children,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children ?? [],
    );
  }
}


class SmallRate extends StatelessWidget {
  final double rate;
  const SmallRate({Key? key,required this.rate}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: RatingBar.builder(
        itemSize: 14,
        initialRating:rate,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        tapOnlyMode: false,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}

