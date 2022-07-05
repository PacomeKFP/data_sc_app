import 'package:flutter/material.dart';

class CustomTextField {
  final String title;
  final String placeholder;
  
  CustomTextField({
    this.title = "",
    this.placeholder = "",
  });
  textFormField({required TextEditingController? txtController, double Width = 300, bool obscure = false}) {
    return Container(
        width: Width,
        child: TextField(
          obscureText: obscure,
          controller: txtController,
          decoration: InputDecoration(
            hintText: this.placeholder,
            filled: true,
            fillColor: Color.fromARGB(255, 250, 250, 255),
            labelText: this.title,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ));
  }
}
