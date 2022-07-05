import 'dart:js';

import 'package:data_sc_tester/UserPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(AchatFormation(formation: 'NONE', courses: {}));
}

double height = 0, width = 0;

class AchatFormation extends StatelessWidget {
  final String formation;
  final Map<String, bool> courses;
  const AchatFormation(
      {Key? key, required this.formation, required this.courses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic?> DATA =
        //Informations sur la formation !
        {
      'formation_id': 'ML01',
      'name': "Machine leaning",
      'price': 230000, //ici c'est juste les donneees de la fonmation
      'description':
          "Ici vous apprendrez à ecrire des modele basiques d'apprentissage machine  ",
      'debouche': "Vous ferez de l'IA, c'est les debouchées en tout cas !",
      'employeur': "Travailler chez Togettech\n Chez LegionWeb ()",
      'start': DateTime.now().toString(),
      //Maintenant les données des cours de la formation
      'course': [
        //premier cours
        {
          'cours_id': 'COURS_ML01',
          'name': 'Base de données',
          'description': "1er cours, desc",
          'price': 23000
        },
        //2eme cours
        {
          'cours_id': 'COURS_ML02',
          'name': 'Modelisation',
          'description': "2eme cours, desc",
          'price': 23000
        },
        //3eme cours

        {
          'cours_id': 'COURS_ML03',
          'name': 'Initiation à Python',
          'description':
              "On vous initiera au langage Python, eut aux modules utiles en machine Learning",
          'price': 23000
        },
        //4eme cours
        {
          'cours_id': 'COURS_ML04',
          'name': 'TP: La reconnaissance facile',
          'description': "4eme cours, desc",
          'price': 23000
        },
      ]
    };

    String formation_name = DATA[formation];
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        title: 'DATA SCIENCE PROJECT - UserHome',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Padding(
          padding: EdgeInsets.all(width / 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  "Achetez votre cours maintenat !, \n formation : $formation_name"),
              /***
               * Ici on affichera la liste des cours de la formation, toàus precédés d'un checkbox
               * Celui cii permettra de 
               */

              OutlinedButton.icon(
                  icon: Icon(Icons.home_max_rounded),
                  label: Text("Ma page d'acceuil"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => UserHome())));
                  }),
            ],
          ),
        )));
  }
}
