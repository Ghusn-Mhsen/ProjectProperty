import 'package:flutter/material.dart';
class TextInput extends StatelessWidget { // ignore: must_be_immutable
  var controller;
  var valid;
  String hint;
  var icon;
  TextInput({this.valid,this.icon,this.controller,this.hint});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        controller: controller,
        validator: valid,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
