
import 'package:data_sc_tester/GetStarted.dart';
import 'package:flutter/material.dart';
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
        children: [
          Head(),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body()
        ],
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
                    MaterialPageRoute(builder: (context) => UserHome()));
              },
              child: Text("Sauter"),
            )),
//========================Boutton Sautter FIN=====================
            Container(width: 20, height: 20),


//=========================Boutton CONTINUER=====================

            ElevatedButton(
              onPressed: () {
                      //Form Submission !

              //Form Submission !

            //==================================================================

                bool isSubmitted =/** True in developpment */
                    true; //will take true if the form is well filled and submitted
                  
            //=================================================================

                //TODO: collecter  en envoyer les informations
                var profession =_profilControllers['profession']?.text;
                var experience =_profilControllers['experience']?.text;
                var employeur =_profilControllers['employeur']?.text;
                var diplome =_profilControllers['diplome']?.text;
                var ecole =_profilControllers['ecole']?.text;
                var domaine =_profilControllers['domaine']?.text;
                var profession_visee = _profilControllers['profession_visee']?.text;
                var secteur =_profilControllers['secteur']?.text;
                var last =_profilControllers['last']?.text;

                if (isSubmitted == true) {
                  dispose();
                  print("Form Submitted well");
                  //go to next page
                  print(
                    '$profession - $experience - $employeur - $diplome - $ecole - $domaine '+
                    '-$profession_visee - $secteur -$last '
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const GetStarted()));
                }
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
  CustomTextField TextField1 =
      new CustomTextField(title: Champs1, placeholder: ' ');
  CustomTextField TextField2 =
      new CustomTextField(title: Champs2, placeholder: ' ');
  CustomTextField TextField3 =
      new CustomTextField(title: Champs3, placeholder: ' ');

  return Container(
    child: Column(
      children: [
        Row(
          children: [Text(title, style: TextStyle(fontSize: 20))],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Column(
              children: [
                IntrinsicWidth(child: TextField1.textFormField(txtController :contro1))
              ],
            ),
            Spacer(flex: 1),
            Column(
              children: [
                IntrinsicWidth(child: TextField2.textFormField(txtController :contro2))
              ],
            ),
            Spacer(flex: 1),
            Column(
              children: [
                IntrinsicWidth(child: TextField3.textFormField(txtController :contro3))
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
