import 'package:fixawy_app/app/storage/storage.dart';
import 'package:fixawy_app/network/models/Complain.dart';
import 'package:fixawy_app/network/models/user_type.dart';
import 'package:fixawy_app/pages/complain_reply/complain_reply_view.dart';
import 'package:fixawy_app/pages/settings/settings_view.dart';
import 'package:fixawy_app/pages/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/models/user.dart';
import 'complain_get_logic.dart';

class ComplainGetPage extends StatefulWidget {
  static const String routeName = "/ComplainGetPage";
  const ComplainGetPage({Key? key}) : super(key: key);
  @override
  _ComplainGetPageState createState() => _ComplainGetPageState();
}

class _ComplainGetPageState extends State<ComplainGetPage> {
  final logic = Get.put(ComplainGetLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Get.find<UserData>().userType == UserType.ADMIN ? AppBar(
        centerTitle: true,
        title: const Text("جميع الشكاوي"),
        leading: IconButton(
          onPressed: ()async{
            await Storage.removeUser();
            Get.find<UserData>().fromJson(null);
            Get.offAllNamed(SignInPage.routeName);
          },
          icon: const Icon(Icons.logout),
        ),
      ) : null,
      body: FutureBuilder<List<Complain>>(
        future: logic.getAllComplains(),
        builder: (context,snapShot){

          if(snapShot.data == null){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Complain> list = snapShot.data!;

          return ListView.separated(
              itemBuilder: (context,index){

                Complain complain = list[index];

                return ListTile(
                  onTap: ()async{
                    await Get.toNamed(ComplainReplyPage.routeName,arguments: complain);
                    setState(() {});
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundImage: Image.network(complain.user!.image!, fit: BoxFit.contain).image,
                    ),
                  ),
                  title: Text(complain.user!.name!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text( " الشكوى :  " + complain.theComplain!),
                      Text( " مقدم الخدمة :  " + complain.serviceProvider!.name!),
                      Text( "  المعرف :  " + complain.serviceProvider!.id!),

                      if(complain.reply != null) Text( "  اخر رد على هذه الشكوى  :  " + complain.reply!,style: const TextStyle(color: Colors.green),),

                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.message,color: Colors.black,),
                    onPressed: ()async{
                      await Get.toNamed(ComplainReplyPage.routeName,arguments: complain);
                      setState(() {});
                    },
                  ),
                );
              },
              separatorBuilder: (context,index){
                return const Divider(height: 20,);
              },
              itemCount: list.length
          );

        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ComplainGetLogic>();
    super.dispose();
  }
}