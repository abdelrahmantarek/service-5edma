import 'package:fixawy_app/CustomWidget/edit_box_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'complain_reply_logic.dart';

class ComplainReplyPage extends StatefulWidget {
  static const String routeName = "/ComplainReplyPage";
  const ComplainReplyPage({Key? key}) : super(key: key);
  @override
  _ComplainReplyPageState createState() => _ComplainReplyPageState();
}

class _ComplainReplyPageState extends State<ComplainReplyPage> {
  final controller = Get.put(ComplainReplyLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرد على الشكوى"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          ListTile(
            onTap: (){
              Get.toNamed(ComplainReplyPage.routeName,arguments: controller.complain);
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            leading: SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                backgroundImage: Image.network(controller.complain.user!.image!, fit: BoxFit.contain).image,
              ),
            ),
            title: Text(controller.complain.user!.name!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text( " الشكوى :  " + controller.complain.theComplain!),
                Text( " مقدم الخدمة :  " + controller.complain.serviceProvider!.name!),
                Text( "  المعرف :  " + controller.complain.serviceProvider!.id!),

                const SizedBox(height: 20,),

                if(controller.complain.reply != null) Text( "  اخر رد على هذه الشكوى  :  " + controller.complain.reply!,style: TextStyle(color: Colors.green),),
              ],
            ),
          ),


          EditBox1(
            controller: controller.textEditingController,
            hint: "اكتب ردك",
            onTapSend: (){
              controller.sendReply();
            },
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ComplainReplyLogic>();
    super.dispose();
  }
}