import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final Function(String) onSubmitted;
  final Function(String) onChanged;
  final FocusNode focusNode;
  final TextInputAction
      textInputAction; //to be used for changing the keyboard button to next
  final bool
      isPwField; //textfield has a property called obscureText which can be set to true or false
  CustomTextField(
      {this.text,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPwField});

  @override
  Widget build(BuildContext context) {
    bool pwField = isPwField ??
        false; //we need a private variable as public one won't work inside the custom class

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 7.0,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        obscureText:
            pwField, //if we declare isPwField as true in the create_acc page, this will automatically become true.
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        textInputAction: textInputAction,
        enableSuggestions: true,
        //hinttext is dynamic
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0)),
      ),
    );
  }
}
