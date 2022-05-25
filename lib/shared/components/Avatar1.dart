



import 'dart:io';
import 'package:fixawy_app/extensions/StyleV.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;






class Avatar extends StatefulWidget {
  final bool cameraEditIcon;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapEdit;
  final GestureTapCallback? onTapCamera;
  final String image;
  final double size;
  const Avatar({Key? key, this.cameraEditIcon = false,required this.image, this.size = 40, this.onTap, this.onTapEdit, this.onTapCamera}) : super(key: key);
  @override
  AvatarState createState() => AvatarState();
}

class AvatarState extends State<Avatar> {

  late String _image;

  File? file;


  bool get hasImage{
    return file != null;
  }

  changeAvatar(String image){
    _image = image;
    setState(() {});
  }



  Future<ImageSource?> _popSheetType()async{
    dynamic result = await showModalBottomSheet(
        isScrollControlled: false,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: Colors.transparent,
        context: context, builder: (context){
      return CustomSheetPickImage(
        onTapCamera: (){
          Navigator.pop(context,ImageSource.camera);
        },
        onTapGallery: (){
          Navigator.pop(context,ImageSource.gallery);
        },
      );
    });
    return result;
  }



  @override
  void initState() {
    _image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        IconButton(
          onPressed:widget.onTapCamera ?? widget.onTap,
          padding: const EdgeInsets.all(0),
          iconSize: widget.size,
          icon:  Builder(
            builder: (context){

              ImageProvider imageProvider(){
                if(file != null){
                  return FileImage(file!);
                }
                return _image.isUrl ? Image.network(_image,width: widget.size,height: widget.size,).image : Image.asset(_image,width: widget.size,height: widget.size,).image;
              }


              return Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:imageProvider()
                    )
                ),
              );
            },
          ),
        ),

        if(widget.onTapCamera != null) Positioned(child: IconButton(
          onPressed:widget.onTapCamera,
          iconSize: 40,
          icon: const Icon(Icons.camera),
        ),right: 10,top: 0,)

      ],
    );
  }
}



class CustomSheetPickImage extends StatelessWidget {
  final GestureTapCallback? onTapCamera;
  final GestureTapCallback? onTapGallery;
  const CustomSheetPickImage({Key? key, this.onTapCamera, this.onTapGallery}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  onTap: onTapCamera,
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: onTapGallery,
                  title: const Text("Gallery"),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),bottom: 0,right: 0,left: 0,)
      ],
    );
  }
}


