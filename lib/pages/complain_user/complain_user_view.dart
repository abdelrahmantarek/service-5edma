import 'package:fixawy_app/network/models/Complain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'complain_user_logic.dart';

class ComplainUserPage extends StatefulWidget {
  static const String routeName = "/ComplainUserPage";
  const ComplainUserPage({Key? key}) : super(key: key);
  @override
  _ComplainUserPageState createState() => _ComplainUserPageState();
}

class _ComplainUserPageState extends State<ComplainUserPage> {
  final controller = Get.put(ComplainUserLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("جميع الشكاوي الخاصة بي"),
      ),
      body: FutureBuilder<List<Complain>>(
        future: controller.getMyComplain(),
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
                      Text( " الشكوى  :  " + complain.theComplain!),
                      Text( " في مقدم خدمة  :  " + complain.serviceProvider!.name!),
                      Text( "  المعرف الخاص به هو  :  " + complain.serviceProvider!.id!),

                      Divider(),

                      if(complain.reply != null) Text( "  لقد تم الرد من قبل المدير  :  " + complain.reply!,style: TextStyle(color: Colors.green),),

                      Divider(),


                    ],
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
    Get.delete<ComplainUserLogic>();
    super.dispose();
  }
}