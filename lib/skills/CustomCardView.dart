// ignore_for_file: non_constant_identifier_names, unused_label
import 'dart:convert';
import 'package:data_sc_tester/CompleterProfil.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/skills/ToastWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Presentation.dart';

class CustomCardView {
  final String formation_id;
  final String title;
  final String description;
  final String image;
  final Map formation;
  final bool completed;
  CustomCardView(
      {required this.formation_id,
      required this.completed,
      required this.formation,
      this.title = "",
      this.description = "",
      this.image = ""});
  Widget cardview(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double cardW = 300;
    double cardH = 600;
    double height = MediaQuery.of(context).size.height;

    double paddingW = cardW / width < 0.1 ? 5 : 10;
    double paddingH = cardH / width < 0.1 ? 6 : 12;
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20)),
      width: cardW,
      height: cardH,
      child: Center(
          child: Column(children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child:
              Image.network(image, width: cardW, height: 300, fit: BoxFit.fill),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          width: cardW,
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 3),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              ),
              const SizedBox(height: 3),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: completed
                          ? MaterialStateProperty.all(Colors.lightGreenAccent)
                          : MaterialStateProperty.all(Colors.lightBlueAccent)),
                  onPressed: () {
                    completed
                        ? makeToast(
                            msg:
                                "Vous Avez deja Acheté toute la formation, Rendez vous en salle pour les cours pratiques",
                            context: context,
                            type: 'info')
                        : _is_inscrits(context, formation_id);
                  },
                  child: completed
                      ? const Icon(
                          Icons.check,
                          color: Colors.lightGreen,
                        )
                      : Text('Souscrire')),
              const SizedBox(height: 3),
              Text(
                description.substring(0, 60),
                softWrap: true,
                overflow: TextOverflow.fade,
              ),
            ],
          ),
        )
      ])),
    );
  }
}

//Les fonctions de

_is_inscrits(context, formation_id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var res = await CallApi().postData({}, 'is-inscrit');
  var body = json.decode(res.body);
  var res_get_formation =
      await CallApi().postData({}, "get-details-formation/$formation_id");
  var body_get_formation = json.decode(res_get_formation.body);
  print(body_get_formation['status']);
  if (await body['inscrit?'] == true) {
    if (body_get_formation['status'] == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => PresentAndBuyFormation(
                    formation_id: formation_id!,
                    formation: body_get_formation['formation'],
                  ))));
    } else {
      print(body_get_formation['message']);
    }
  } else {
    prefs.setString('inscrits?', 'no');
    prefs.setString('formation_id', formation_id);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const InscriptionPage(
                  provenance: 'home',
                )));
  }
}
