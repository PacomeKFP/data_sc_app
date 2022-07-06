// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTextField {
  final String title;
  final String placeholder;
  
  CustomTextField({
    this.title = "",
    this.placeholder = "",
  });
  textFormField({required TextEditingController? txtController, double width = 300, bool obscure = false,}) {
    return SizedBox(
        width: width,
        child: TextField(
          
          obscureText: obscure,
          controller: txtController,
          decoration: InputDecoration(
            // suffixIcon: IconButton(icon: Icon(Icons.visibility_outlined),)
            hintText: placeholder,
            filled: true,
            fillColor: const Color.fromARGB(255, 250, 250, 255),
            labelText: title,
            labelStyle:const TextStyle(fontSize: 12),
            contentPadding:const  EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide:const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:const BorderSide(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ));
  }
}
