



import 'package:flutter/material.dart';


class EditText extends StatefulWidget {
  final IconData? icon;
  final String? hint;
  final String? label;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  const EditText({Key? key, this.icon, this.hint, this.label, this.controller, this.validator, this.maxLines = 1, this.minLines = 1, this.maxLength = 35}) : super(key: key);
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
    return TextFormField(
      focusNode: focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.only(left: 15),
          child: Icon(widget.icon,color: focusNode.hasFocus ? Theme.of(context).accentColor : Colors.grey ),
        ),
        hintText: widget.hint,
      ),
      style: const TextStyle(
          color: Color(0xFF0148A4)
      ),
      validator: widget.validator,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
    );
  }
}
