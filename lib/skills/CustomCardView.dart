// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:data_sc_tester/CompleterProfil.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Presentation.dart';

class CustomCardView {
  final String formation_id;
  final String title;
  final String description;
  final String image;
  final Map formation;
  CustomCardView(
      {required this.formation_id, required this.formation, 
      this.title = "",
      this.description = "",
      this.image = ""});
  Wrap cardview(BuildContext context) {
    return Wrap(children: [
      Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                child: Center(
                    child: Column(children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 3),
                  Image.network(image,
                      width: 150, height: 150, fit: BoxFit.fill),
                  const SizedBox(height: 3),
                  ElevatedButton(
                      onPressed: () {
                        _is_inscrits(context, formation_id);
                         
                      }, 

                      child: const Text('Souscrire')),
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Text(description.substring(
                        0, description.length < 40 ? description.length : 40)),
                  ),
                ])),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
 _is_inscrits(context, formation_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var res = await CallApi().postData({}, 'is-inscrit');
    var body = json.decode(res.body);
    var res_get_formation = await CallApi().postData({}, "get-details-formation/$formation_id"); 
    var body_get_formation = json.decode(res_get_formation.body);
    print(body_get_formation['status']);
    if (await body['inscrit?'] == true) {
      if (body_get_formation['status'] == 200) {
           Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => PresentAndBuyFormation(
                formation_id:  formation_id!,
                formation: body_get_formation['formation'],)))); 
         } else {
           print(body_get_formation['message']);
         }
    } else {
      
      prefs.setString('inscrits?', 'no');
      prefs.setString('formation_id', formation_id);
      Navigator.push( context, MaterialPageRoute(builder: (context) => const  InscriptionPage()));
    } 
 }