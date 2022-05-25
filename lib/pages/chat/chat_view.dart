import 'package:fixawy_app/CustomWidget/app_bar_1.dart';
import 'package:fixawy_app/CustomWidget/edit_box_1.dart';
import 'package:fixawy_app/CustomWidget/item_message_me_1.dart';
import 'package:fixawy_app/CustomWidget/item_message_other_1.dart';
import 'package:fixawy_app/CustomWidget/loading.dart';
import 'package:fixawy_app/network/models/message.dart';
import 'package:fixawy_app/network/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_logic.dart';


class ChatPage extends StatefulWidget {
  static const String routeName = "/ChatPage";
  const ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final ChatLogic controller = Get.put(ChatLogic());

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: Get.theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(const AppBar1().preferredSize.height),
              child: AppBar1(
                name: controller.reservation.serviceProvider!.name.toString(),
                lastSeen: "",
              ),
            ),
            body: Column(
              children: <Widget>[

                Expanded(child: Stack(
                  children: [

                    Obx((){

                      if(!controller.firstLoad.value){
                        return const LoadingList();
                      }

                      return ListView.builder(
                        itemCount: controller.listMessages.length,
                        reverse: true,
                        itemBuilder: (c,i){
                          Message messages = controller.listMessages[i];
                          bool isLast = controller.listMessages.last.messageKey == messages.messageKey;
                          bool isFirst =  controller.listMessages.first.messageKey == messages.messageKey;
                          return Container(
                              margin: EdgeInsets.only(top: isLast ? 50 : 0.0,bottom: isFirst ? 25 : 0.0),
                              child: messages.isMe
                                  ? ItemMessageMe1(message: messages.messageText,time: messages.getTime(),)
                                  : ItemMessageOther1(message: messages.messageText,time: messages.getTime(),));

                        },
                      );

                    }),

                  ],
                )),

                EditBox1(
                  controller: controller.textEditingController,
                  onTapSend: (){
                    controller.sendText();
                  },
                ),

              ],
            ),),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ChatLogic>();
    super.dispose();
  }
}