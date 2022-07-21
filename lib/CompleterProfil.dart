// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'package:data_sc_tester/skills/ToastWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Presentation.dart';
import 'api/CallApi.dart';
import 'skills/TextField.dart';
import 'UserPage.dart';

void main() {
  runApp(const InscriptionPage());
}

class InscriptionPage extends StatelessWidget {
  final String
      provenance; //insciption(si  la page precedentee etait l'inscription, sinon home si c'est UserHomePage)
  const InscriptionPage({Key? key, this.provenance = "inscription"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String txt = "Veuillez remplir quelques informations supplementaires";

    WidgetsBinding.instance.addPostFrameCallback((_) => makeToast(
        msg: provenance == "inscription"
            ? "Vous avez bien été inscrit \n $txt"
            : "$txt, avant de consulter la formation",
        type: "info",
        context: context));

    return const MaterialApp(
      title: 'DC - Profil',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [Head(), const Body()],
      ),
    );
  }
}

class Head extends StatelessWidget {
  Head({Key? key}) : super(key: key);
  var name = "nous";
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height / 10),
        child:
            Text("Aidez $name à vous aidez :", style: const TextStyle(fontSize: 40)));
  }
}

//==============CONTROLERS IMPLEMENTATION============================

final _profilControllers = {
  'profession': TextEditingController(),
  'niveau_exp': TextEditingController(),
  'employeur': TextEditingController(),
  'diplome': TextEditingController(),
  'ecole': TextEditingController(),
  'domaine': TextEditingController(),
  'profession_v': TextEditingController(),
  'secteur': TextEditingController(),
  'last': TextEditingController(),
};

void dispose(Map<String, TextEditingController> map) {
  map.forEach((key, value) {
    map[key]?.dispose();
  });
}

//=====================================================================

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _voletInscription(
          title: 'Expérience Professionelle',
          Champs1: 'Profession',
          Champs2: "Niveau d'niveau_exp",
          Champs3: 'Employeur',
          contro1: _profilControllers["profession"],
          contro2: _profilControllers["niveau_exp"],
          contro3: _profilControllers["employeur"],
        ),
        const SizedBox(height: 30),
        _voletInscription(
          title: 'Education',
          Champs1: 'Diplôme',
          Champs2: 'Université/Ecole',
          Champs3: 'Domaine',
          contro1: _profilControllers["diplome"],
          contro2: _profilControllers["ecole"],
          contro3: _profilControllers["domaine"],
        ),
        const SizedBox(height: 30),
        _voletInscription(
          title: 'Objectif de Carrière',
          Champs1: 'Profession',
          Champs2: 'Secteur',
          contro1: _profilControllers["profession_v"],
          contro2: _profilControllers["secteur"],
          contro3: _profilControllers["last"],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
//=================================Boutton Sautter=====================
            IntrinsicWidth(
                child: OutlinedButton(
              onPressed: () {
                debugPrint('Received click');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserHome()));
              },
              child: const Text("Sauter"),
            )),
//========================Boutton Sautter FIN=====================
            const SizedBox(width: 20, height: 20),

//=========================Boutton CONTINUER=====================

            ElevatedButton(
              onPressed: () {
                // ignore: todo
                //TODO: collecter  en envoyer les informations
                var data = {};
                _profilControllers.forEach((key, value) {
                  data[key] = value.text;
                });
                _completerInscription(data, context);
              },
              child: const Text('Continuer'),
            )
//=========================Boutton Continuer FIN=====================
          ],
        )
      ],
    );
  }

  _completerInscription(data, context) async {
    makeToast(
        msg:
            "Veuillez patienter, nous prenons compte des informations renseignées",
        type: 'info',
        context: context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var formation_id = prefs.getString('formation_id');
    var _is_inscrit = prefs.getString('inscrits?');
    var id = prefs.getInt('id');
    data['formation_id'] = '0';

    var res = await CallApi().postData(data, "new-inscrit");
    var res_get_formation = await CallApi().postData(data,
        "get-details-formation/$formation_id"); //get-details-formation/{id}
    var body = json.decode(res.body);
    var body_get_formation = json.decode(res_get_formation.body);

    if (body['status'] == 200) {
      if (_is_inscrit == 'no') {
        prefs.remove('formation_id');
        prefs.remove('_is_inscrit');
        if (body_get_formation['status'] == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => PresentAndBuyFormation(
                        formation_id: formation_id!,
                        formation: body_get_formation['formation'],
                      ))));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>  UserHome()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  UserHome()));
      }
    } else {
      makeToast(
          msg:
              "Une erreur est survenue, veuillez verifier votre acces à internet",
          type: 'alert',
          context: context);
      print(body['message']);
    }
  }
}

Widget _voletInscription({
  String title = " ",
  String Champs1 = " ",
  String Champs2 = " ",
  String Champs3 = "",
  TextEditingController? contro1,
  TextEditingController? contro2,
  TextEditingController? contro3,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontSize: 20)),
      const SizedBox(height: 15),
      Wrap(
        spacing: 2.0,
        runSpacing: 10.0,
        children: [
          CustomTextField(title: Champs1, placeholder: ' ')
              .textFormField(txtController: contro1),
          CustomTextField(title: Champs2, placeholder: ' ')
              .textFormField(txtController: contro2),
          CustomTextField(title: Champs3, placeholder: ' ')
              .textFormField(txtController: contro3),
        ],
      ),
    ],
  );
}
