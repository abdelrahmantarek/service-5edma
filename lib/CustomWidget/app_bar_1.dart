
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class AppBar1 extends StatelessWidget implements PreferredSizeWidget{
  final String name;
  final String lastSeen;
  const AppBar1({Key? key, this.name = "Customer Service", this.lastSeen = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5,),
              IconButton(onPressed: (){
                Get.back();
              }, icon: const Icon(Icons.arrow_back_outlined)),
              const SizedBox(width: 5,),
              CircleAvatar(
                backgroundImage: Image.asset("assets/images/user.png").image,
              ),
              const SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(name,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText1,),
                  Opacity(opacity: 0.5,child: Text(lastSeen,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize! * 80 / 100),),),
                ],
              )
            ],
          ),
        ),

      ],
    );
  }
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

