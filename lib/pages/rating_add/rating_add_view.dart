import 'package:fixawy_app/pages/rating_service_provider/rating_service_provider_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';



class RatingAddPage extends StatefulWidget {
  static const String routeName = "/RatingAddPage";
  const RatingAddPage({Key? key}) : super(key: key);
  @override
  _RatingAddPageState createState() => _RatingAddPageState();
}

class _RatingAddPageState extends State<RatingAddPage> {

  TextEditingController textEditController = TextEditingController();
  FocusNode focusNode = FocusNode();


  String? _selectedValue;
  List<String> listOfValue = ['1', '2', '3', '4', '5'];

  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(

              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  Text(
                    Get.find<RatingServiceProviderLogic>().serviceProvider.name.toString(),
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 23,
                      color: Color(0x8e000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),

                  const SizedBox(height: 20,),

                  CustomEditText1(
                    hint: "كتابة التقيم",
                    controller: textEditController,
                    focusNode: focusNode,
                    loading: false,
                    onPressedSend: (){

                    },
                    validator: (text){
                      return null;
                    },
                  ),



                  const SizedBox(height: 20,),

                  RatingBar.builder(
                    itemSize: 45,
                    initialRating: 0.5,
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
                     this.rating = rating;
                    },
                  ),

                  const SizedBox(height: 20,),

                  CustomButton1(
                    text: "ارسال",
                    onTap: (){
                      Get.find<RatingServiceProviderLogic>().sendRating(rating,textEditController.text);
                      Get.back();
                    },
                    color: const Color(0xFF3ACCE1),
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}




class CustomEditText1 extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final bool loading;
  final VoidCallback? onPressedSend;
  final FormFieldValidator<String>? validator;
  final Widget? header;
  const CustomEditText1({Key? key, this.controller, this.focusNode,this.hint, this.loading = false, this.onPressedSend, this.validator,this.header}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if(header != null) header!,
        Material(
          color: Colors.grey.shade200,
          elevation: 0,
          shadowColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
            child: Row(
              children: [

                Expanded(child: TextFormField(
                  controller: controller,
                  scrollPadding: const EdgeInsets.only(bottom: 60.0),
                  // autofocus: false,
                  focusNode: focusNode,
                  maxLines: null,
                  minLines: 3,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  validator: validator,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                    hintText: hint ?? '',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    errorStyle: const TextStyle(
                        height: 0.10
                    ),
                    hintMaxLines: 1,
                    errorMaxLines: 1,
                    helperMaxLines: 1,
                    prefixIconColor: const Color(0XFF8592AD),
                    suffixIconColor: const Color(0XFF8592AD),
                  ),
                )),

              ],
            ),
          ),
        )
      ],
    );
  }
}



class CustomButton1 extends StatelessWidget {
  final String text;
  final IconData? iconData;
  final Color? color;
  const CustomButton1({
    Key? key,
    this.onTap,
    required this.text,
    this.color,
    this.iconData,
  }) : super(key: key);
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: RaisedButton(onPressed: onTap,
        padding: EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if(iconData != null) const SizedBox(
              width: 4,
            ),
            if(iconData != null) Icon(
              iconData!,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
        color: color,),
    );
  }
}
