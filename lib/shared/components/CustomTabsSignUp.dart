


// CustomTabsInfoReview


import 'package:flutter/material.dart';


enum SignInType{
  SIGN_IN,
  SIGN_UP,
}

class UserTypeTabs extends StatefulWidget {
  final ValueChanged<SignInType> onChanged;
  const UserTypeTabs({Key? key,required this.onChanged}) : super(key: key);
  @override
  UserTypeTabsState createState() => UserTypeTabsState();
}

class UserTypeTabsState extends State<UserTypeTabs> with SingleTickerProviderStateMixin{

  List<SignInType> category = [
    SignInType.SIGN_IN,
    SignInType.SIGN_UP,
  ];

  SignInType categorySelected = SignInType.SIGN_IN;

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, vsync: this, length: category.length,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Widget tab(String title,bool selected){
      return AnimatedOpacity(
        opacity: selected ? 1.0 : 0.5,
        duration: const Duration(
            milliseconds: 200
        ),
        child:Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 12,horizontal: MediaQuery.of(context).size.width * 10 / 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:Colors.black,
                border: !selected ? Border.all(color: Colors.grey,width: 0.2) : null,
                boxShadow: const [
                  BoxShadow()
                ]
            ),
          child: Text(title,style: TextStyle(
              color: selected ? Colors.white : Colors.grey
          ),),
        ),
      );
    }

    return TabBar(
      padding: const EdgeInsets.all(0),
      controller:tabController,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      enableFeedback: true,
      physics: const BouncingScrollPhysics(),

      indicator:  BoxDecoration(
          color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),

      tabs:[
        Tab(text: "SIGN IN",),
        Tab(text: "SIGN UP",),
      ],
      onTap: (index){
        categorySelected = category[index];
        widget.onChanged(categorySelected);
        setState(() {});
      },
    );
  }
}