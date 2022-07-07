import 'dart:convert';

import 'package:data_sc_tester/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/CallApi.dart';
import 'skills/TextField.dart';
import 'UserPage.dart';

void main() {
  runApp(InscriptionPage());
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
  'experience': TextEditingController(),
  'employeur': TextEditingController(),
  'diplome': TextEditingController(),
  'ecole': TextEditingController(),
  'domaine': TextEditingController(),
  'profession_visee': TextEditingController(),
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
          contro2: _profilControllers["experience"],
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
          contro1: _profilControllers["profession_visee"],
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
                    MaterialPageRoute(builder: (context) => const UserHome()));
              },
              child: Text("Sauter"),
            )),
//========================Boutton Sautter FIN=====================
            Container(width: 20, height: 20),

//=========================Boutton CONTINUER=====================

            ElevatedButton(
              onPressed: () {
                //TODO: collecter  en envoyer les informations
                var data = {
                  'profession': _profilControllers['profession']?.text,
                  'experience': _profilControllers['experience']?.text,
                  'employeur': _profilControllers['employeur']?.text,
                  'diplome': _profilControllers['diplome']?.text,
                  'ecole': _profilControllers['ecole']?.text,
                  'domaine': _profilControllers['domaine']?.text,
                  'profession_visee':
                      _profilControllers['profession_visee']?.text,
                  'secteur': _profilControllers['secteur']?.text,
                  'last': _profilControllers['last']?.text
                };
                print("object");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    print("id :$id");
    data['user_id'] = id;
    data['formation_id'] = 0;
    print("before");
    var res = await CallApi().getData(data);
    var body = json.decode(res.body);
    print("data : ${data}");
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
