import 'dart:convert';

import 'package:data_sc_tester/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/CallApi.dart';
import 'skills/TextField.dart';
import 'UserPage.dart';

void main() {
  runApp(const InscriptionPage());
}

class InscriptionPage extends StatelessWidget {
  const InscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Completez votre profil',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [Head(), Body()],
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
            Text("Aidez $name à vous aidez :", style: TextStyle(fontSize: 40)));
  }
}

//==============CONTROLERS IMPLEMENTATION============================

final _profilControllers = {
  'profession': TextEditingController(),
  'niveau_ex': TextEditingController(),
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        _voletInscription(
          title: 'Expérience Professionelle',
          Champs1: 'Profession',
          Champs2: "Niveau d'Experience",
          Champs3: 'Employeur',
          contro1: _profilControllers["profession"],
          contro2: _profilControllers["niveau_ex"],
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
              onPressed: () {},
              child: Text("Sauter"),
            )),
//========================Boutton Sautter FIN=====================
            Container(width: 20, height: 20),

//=========================Boutton CONTINUER=====================

            ElevatedButton(
              onPressed: () {
                var data = {};
                _profilControllers.forEach((key, value) {
                  data[key] = value.text;
                });
                // _profilControllers.forEach((key, value) {
                //  data.add
                // });
                _completeInscription(data, context);
              },
              child: const Text('Continuer'),
            )
//=========================Boutton Continuer FIN=====================
          ],
        )
      ],
    );
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
      Text(title, style: TextStyle(fontSize: 20)),
      SizedBox(height: 15),
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

_completeInscription(data, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getInt('id');
  data['user_id'] = id;
  data['formation_id'] = 0;
  var res = await CallApi().getData(data);
  var body = json.decode(res.body);
  print('ici');
}
