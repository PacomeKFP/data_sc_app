// ignore_for_file: non_constant_identifier_names

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AchatFormation.dart';

void main() {
  runApp(DescrFormation());
}

double height = 0, width = 0;

class DescrFormation extends StatefulWidget {
  final String formation;
  DescrFormation({Key? key, this.formation="ML01"});

  @override
  State<DescrFormation> createState() => _DescrFormationState();
}

class _DescrFormationState extends State<DescrFormation> {
  
  final String formation;
  _DescrFormationState({Key? key, this.formation="ML01"});
  /**
     * Ici on va reccuperer les in formations de la formlation ainsi que de chaque
     * cours qu'il contient et le stocker dans DATA
     */

  Map<String, dynamic> DATA =
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

  //On extrait la liste des des cours contenus dans les données reccupérées
  var courses = [];
  void getCourses() {
    //Pour reccuperer la liste des cours contenus dans les données recues apres les requettes
    for (Map<String, dynamic> course in DATA['course']) {
      courses.add(course);
    }
  }

  /**
     * On peut utiliser uiliser une fonction asynchrone *getData*, qui permettra de donner la valeurs de da
     */
//============================EN BAS C'EST LES GESTIONNAIRE PPOUR LE CHECKBOX
  /**
     *Ici je cree les gestionnair de check box en fontion des id de cours trouvés !
     */

  Map<String, bool> checkBoxGestionner = {};
  Map<String, bool> CourseInView = {};
  //a pratir de lui on pourra savoir quel cours a eté acheté ou pas
  //il sera urilisé directement pour l'achat
  /**
   * Structure--> id_cours : etat (true/false); true s'il prend, fals sinon !
   */
  //on prend un boucle qui va permettre de creer les che
  //======================/= ex
  void initCheckBoxesAndTabMenu() {
    //pour initialiser les checkbox par défaut ils sont tous à true !

    for (Map<String, dynamic> course in courses) {
      checkBoxGestionner[course['cours_id']] = true;
      CourseInView[course['cours_id']] = false;
    }
  }

  void _switchTabMenu(String Key) {
    //Key ici represente un course_id
    setState(() {
      CourseInView.forEach((key, value) {
      CourseInView[key] = false;
    });
    CourseInView[Key] = true;
    });
  }

  //================================

  @override
  Widget build(BuildContext context) {
    initCheckBoxesAndTabMenu();
    getCourses();

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
            body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Color.fromARGB(131, 255, 216, 161),
                expandedHeight: height * 0.1,
                pinned: true,
                floating: true,
                elevation: 10,
                //expandedHeight: 250.0,
                flexibleSpace: Container(
                  padding: EdgeInsets.symmetric(horizontal: width / 8),
                  height: height * 0.12,
                  width: double.infinity,
                  child: FormationName(context),
                )),
            SliverList(
                delegate: SliverChildListDelegate(
                    DetailsFormation(formation: widget.formation))),
          ],
        )));
  }

  List<Widget> DetailsFormation({required String formation}) {
    /**
Commencer par les details de la formation même puis passer à ceux des cours    * 
     */
    return [
      //Elements descriptifs d'une formation
      _bloc('description', 0, -1), _bloc('debouche', 0, -1),
      _bloc('employeur', 0, -1),

      for (int i = 0; i < courses.length; i++)
        CourseBloc(
            courses[i]['course_id'],
            i,
            checkBoxGestionner[courses[i]['course_id']],
            CourseInView[courses[i]['course_id']])

      //On passe à present aux cours dela formation
    ];
  }

  Widget CourseBloc(
      String course_id, int course_index, bool? isActive, bool? inView) {
    return ListTile(
      title: Text(courses[course_index]['name']),
      leading: IconButton(
        icon: Icon(isActive == true
            ? Icons.arrow_downward_rounded
            : Icons.arrow_forward_ios_rounded),
        onPressed: () {
          //derouler, enrouler
          setState(() {
            //On roule toutes les formations ouvertes
            bool callerState = CourseInView[course_id]!;
            CourseInView.forEach((key, value) {
              CourseInView[key] = false;
            });
            CourseInView[course_id] =
                !callerState; //On ouvre la formation en question
          });
        },
      ),

      trailing: IconButton(
          onPressed: () {},
          icon: Icon(checkBoxGestionner[course_id] == true
              ? Icons.radio_button_checked_rounded
              : Icons.close_rounded)),

      // ignore: prefer_const_literals_to_create_immutables
      subtitle: inView == true
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Divider(
                  height: 1, thickness: 2, indent: 3, color: Colors.grey),
              _bloc('description', 1, course_index),
              _bloc('price', 1, course_index),
            ])
          : SizedBox(),
    );
  }

  Widget _bloc(String titleKey, int degree, int course_index) {
    //degree permet de savoir si ce sont les retails dune foremation ou d'un cour que le bloc permet d'afficher
    // degree == 0 --> formation; degree == 1 --> cours
    // pour le infor d'une formation, il suffit de donner course_index -1 car il n'est pas utile
    String content = 'None';
    degree == 0 //pour la formation
        ? content = DATA[titleKey]
        : content = courses[course_index][titleKey];

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
                titleKey == 'debouche' ? "Débouchées" : Capitalise(titleKey)),
            subtitle: Column(
              children: [
                const Divider(
                    height: 1, thickness: 2, indent: 3, color: Colors.grey),
                Text(Capitalise(content)),
              ],
            ),
          ),
          const Divider(
              height: 2,
              thickness: 3,
              indent: 0,
              color: Color.fromARGB(255, 100, 100, 100)),
        ],
      ),
    );
  }

//Pour mettre le premier charactere d'un chaine en majuscule
  String Capitalise(String s) {
    String st = s[0];
    String end = s.substring(1, s.length);
    return st.toUpperCase() + end;
  }

  //Affiche le non de la formation et le boutton acheter,
  //ce dernier envoie l'id de la formation en question et les formations achetées
  // à la page qui affiche cela, pour dire acchat effectué avec succes !
  //cette mee page fera l'achat
  Widget FormationName(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width / 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DATA['name'] + "\n Date de debut:" + DATA['start'],
            style: TextStyle(fontFamily: 'Gabriela', fontSize: 24),
          ),
          OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AchatFormation(
                            formation: DATA['formation_id'],
                            courses: checkBoxGestionner)));
              },
              icon: Icon(Icons.add_shopping_cart_outlined),
              label: Text("S'inscrire"))
        ],
      ),
    );
  }
}
