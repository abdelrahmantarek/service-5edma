


import 'package:flutter/material.dart';


class EditText extends StatefulWidget {
  final IconData? icon;
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final int maxLength;
  final bool number;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  const EditText({Key? key, this.icon, this.hint, this.label, this.controller, this.onTap, this.validator, this.maxLength = 35, this.number = false, this.maxLines = 1, this.onChanged, this.errorText}) : super(key: key);
  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {

  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: widget.onTap,

      child: IgnorePointer(
        ignoring: widget.onTap != null,
        child: Theme(data: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              contentPadding:const EdgeInsets.symmetric(vertical: 20,horizontal: 0,),
              enabledBorder:const UnderlineInputBorder(
                borderSide:  BorderSide(color: Colors.grey,width: 2,style: BorderStyle.solid),
              ),
              focusedBorder:UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor,width: 2,style: BorderStyle.solid),
              ),
              fillColor: Colors.transparent,
              // alignLabelWithHint: true,
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            )
        ), child: TextFormField(
          focusNode: focusNode,
          controller: widget.controller,
          keyboardType: widget.number ? TextInputType.number : TextInputType.text,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            labelText: widget.hint,
            errorText: widget.errorText,
            filled: true,
            isDense: true,
            labelStyle: TextStyle(
              color: widget.onTap != null ? Colors.black : Colors.grey
            )
          ),
          style: const TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 15,
            height: 0.90,
            color:Colors.black,
            fontWeight: FontWeight.w500,
          ),
          validator: widget.validator,
          // maxLength: widget.maxLength,
          maxLines: widget.maxLines,
        )),
      ),
    );
  }
}