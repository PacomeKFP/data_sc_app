import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../UserPage.dart';

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

void dispose() {
  _profilControllers['profession']?.dispose();
  _profilControllers['experience']?.dispose();
  _profilControllers['employeur']?.dispose();
  _profilControllers['diplome']?.dispose();
  _profilControllers['ecole']?.dispose();
  _profilControllers['domaine']?.dispose();
  _profilControllers['profession_visee']?.dispose();
  _profilControllers['secteur']?.dispose();
  _profilControllers['last']?.dispose();
}

//=====================================================================

class MobileInscriptionPage extends StatelessWidget {
  const MobileInscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Flutter Profil Mobile',
      home: Page(), //LoginPage() **En temps normal//*/*InscriptionPage
      debugShowCheckedModeBanner: false,
    );
  }
}

var width, height;

class Page extends StatelessWidget {
  const Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2, right: 2, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _formLogin(context),
                ],
              ),
            ),
          ],
        ));
  }

  Widget MyTextField(TextEditingController? textEdControler, String text) {
    return Column(children: [
      TextField(
        controller: textEdControler,
        decoration: InputDecoration(
          hintText: '$text',
          labelText: '$text',
          filled: true,
          fillColor: Colors.blueGrey[50],
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
      ),
      SizedBox(
        height: 30,
      ),
    ]);
  }

  Widget _formLogin(BuildContext buildContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: const ListTile(
                  title: Text(
                    "Encore Une Etape User_name :",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    "Ajoutez quelques informations supplementaires à votre profil afin que nous puissions mieux vous guider !",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        )),
        Divider(height: height * 0.1),
        Text("Expérience Professionelle"),
        MyTextField(_profilControllers['profession'], "Profession"),
        MyTextField(_profilControllers['experience'], "Niveau d'experience"),
        MyTextField(_profilControllers['employeur'], "Employeur"),

        Text("Education"),
        MyTextField(_profilControllers['diplome'], "Diplome"),
        MyTextField(_profilControllers['ecole'], "Université / Ecole"),
        MyTextField(_profilControllers['domaine'], "Domaine"),

        Text("Objectif de Carrière"),
        MyTextField(_profilControllers['profession_visee'], "Profession visée"),
        MyTextField(_profilControllers['secteur'], "Secteur"),

        //=========================Boutton CONTINUER=====================

        ElevatedButton(
          onPressed: () {
            bool isSubmitted = /** True in developpment */
                true; //will take true if the form is well filled and submitted

            //TODO: collecter  en envoyer les informations
            var profession = _profilControllers['profession']?.text;
            var experience = _profilControllers['experience']?.text;
            var employeur = _profilControllers['employeur']?.text;
            var diplome = _profilControllers['diplome']?.text;
            var ecole = _profilControllers['ecole']?.text;
            var domaine = _profilControllers['domaine']?.text;
            var professionVisee = _profilControllers['profession_visee']?.text;
            var secteur = _profilControllers['secteur']?.text;
            var last = _profilControllers['last']?.text;

            if (isSubmitted == true) {
              dispose();
              print("Form Submitted well");
              //go to next page
              print(
                  '$profession - $experience - $employeur - $diplome - $ecole - $domaine ' +
                      '-$professionVisee - $secteur -$last ');
              Navigator.push(buildContext,
                  MaterialPageRoute(builder: (context) => UserHome()));
            }
          },
          child: const Text('Continuer'),
        )
//=========================Boutton Continuer FIN=====================
      ],
    );
  }
}
