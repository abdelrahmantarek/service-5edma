


import 'package:awesome_card/awesome_card.dart';
import 'package:awesome_card/credit_card.dart';
import 'package:fixawy_app/main.dart';
import 'package:fixawy_app/pages/service_providers/service_providers_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sizer/sizer.dart';




class CardScreen extends StatefulWidget {
  static const String routeName = "CardScreen";
  final String title = "title";
  const CardScreen({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CardScreen> {

  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  bool showBack = false;

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              CreditCard(
                cardNumber: cardNumber,
                cardExpiry: expiryDate,
                cardHolderName: cardHolderName,
                cvv: cvv,
                bankName: 'Axis Bank',
                showBackSide: showBack,
                frontBackground: CardBackgrounds.black,
                backBackground: CardBackgrounds.white,
                showShadow: true,
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Card Number'),
                      maxLength: 19,
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Card Expiry'),
                      maxLength: 5,
                      onChanged: (value) {
                        setState(() {
                          expiryDate = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Card Holder Name'),
                      onChanged: (value) {
                        setState(() {
                          cardHolderName = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'CVV'),
                      maxLength: 3,
                      onChanged: (value) {
                        setState(() {
                          cvv = value;
                        });
                      },
                      focusNode: _focusNode,
                    ),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container(
                        width: Get.width,
                        margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                        child: RoundedLoadingButton(
                            controller: RoundedLoadingButtonController(),
                            height: 35,
                            width: Get.width,
                            borderRadius: 10,
                            onPressed: () async{

                              if(cardNumber.isEmpty || cardHolderName.isEmpty || cvv.isEmpty){
                                Navigator.pop(context);
                                return;
                              }

                              Navigator.pop(context,[
                                cardNumber,
                                cardHolderName,
                                cvv,
                              ]);

                            },
                            animateOnTap: false,
                            color: Get.theme.accentColor,
                            child: Text(
                              "Save",
                              style: Get.textTheme.button!.copyWith(fontSize: 11.sp,color: Colors.white),
                            )),
                      ))
                    ] ,
                  )

                ],

              )
            ],
          ),
        ),
      ),
    );
  }
}