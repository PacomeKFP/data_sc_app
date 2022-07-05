// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures
import 'package:data_sc_tester/UserPage.dart';
import 'package:data_sc_tester/skills/CoursesTab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PresentAndBuyFormation(formation_id: 'No formation Selected'));
}

double height = 0, width = 0;

class PresentAndBuyFormation extends StatefulWidget {
  final String formation_id;
  const PresentAndBuyFormation({Key? key, this.formation_id = "ML01"})
      : super(key: key);

  @override
  State<PresentAndBuyFormation> createState() => _PresentAndBuyFormationState();
}

class _PresentAndBuyFormationState extends State<PresentAndBuyFormation> {
  /// Ici on va reccuperer les in formations de la formlation ainsi que de chaque
  /// cours qu'il contient et le stocker dans formation

  Map<String, dynamic> formation =
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
  };

  //On extrait la liste des des cours contenus dans les données reccupérées
  List<Map<String, dynamic>> courses = [
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
    }
  ];

  /*
      On peut utiliser uiliser une fonction asynchrone *getformation*, qui permettra de donner la valeurs de da
     */
//============================EN BAS C'EST LES GESTIONNAIRE PPOUR LES CHECKBOX
  /*
     Ici je cree les gestionnaire de check box en fontion des id de cours trouvés !
     */

  Map<String, bool> checkBoxGestionner = {};
  //a pratir de lui on pourra savoir quel cours a eté acheté ou pas
  //il sera utilisé directement pour l'achat

  /*
    Structure--> id_cours : etat (true/false); true s'il prend, fals sinon !
   */

  void initCheckBoxes() {
    //pour initialiser les checkbox par défaut ils sont tous à true !
    for (Map<String, dynamic> course in courses)
      checkBoxGestionner[course['cours_id'].toString()] = true;
  }

  String courseKeyToDisplay = "-";
  double montantTotal = 0;

  void pressEvent(String key, int degree) {
    setState(() {
      if (degree == 0)
        courseKeyToDisplay = courseKeyToDisplay == key ? "" : key;
      else if(degree == 1)
        checkBoxGestionner[key] =
            checkBoxGestionner[key] == true ? false : true;
    });
    updateMontantTotal();//on met à jour le montant total à payer !
  }

  void updateMontantTotal() {//permet de mettre 0 jour le montant total à payer
    bool allBuyed = true;
    montantTotal = 0;
    setState(() {
      checkBoxGestionner.forEach((key, value) {
        if (value == false)
          allBuyed = false;
        else
          for (Map<String, dynamic> course in courses)
            if (course['cours_id'].toString() == key)
              montantTotal += (course['price'] as double);
      });
      if(allBuyed)///tarif special
        montantTotal *= 0.8; //reduction de 20% 
    }); 
  }

  //================================

  @override
  Widget build(BuildContext context) {
      
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        title: 'TRAINING PRESENTATION',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: const Color.fromARGB(230, 255, 216, 161),
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
                    DetailsFormation(formation_id: widget.formation_id))),
          ],
        )));
  }

  List<Widget> DetailsFormation({required String formation_id}) {
    /**
Commencer par les details de la formation même puis passer à ceux des cours    * 
     */
    return [
      //Elements descriptifs d'une formation
      _bloc('description', 0, -1), _bloc('debouche', 0, -1),
      _bloc('employeur', 0, -1),

      //On passe à present aux cours de la formation
      CoursesBloc(courses: courses, pressEvent: pressEvent).getCoursesBloc(
          inView: courseKeyToDisplay, bloc: _bloc, box: checkBoxGestionner),

      //Boutton de souscripttion avec prix total à payer !
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Prix total : ${montantTotal}F"),
          const SizedBox(width: 1),
          TextButton.icon(
              onPressed: () => print("buy Courses ${checkBoxGestionner}"),
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: Text("Finaliser l'achat !"))
        ],
      )
    ];
  }

  Widget _bloc(String titleKey, int degree, int course_index) {
    // degree permet de savoir si ce sont les details dune formation ou d'un cour que le bloc permet d'afficher
    // degree == 0 --> formation; degree == 1 --> cours
    // pour le info d'une formation, il suffit de donner course_index -1 car il n'est pas utile
    String content = 'None';
    degree == 0 //pour la formation
        ? content = formation[titleKey].toString()
        : content = courses[course_index][titleKey].toString();

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
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ListTile(
              title: Text(
                formation['name'],
                style: const TextStyle(fontSize: 24),
              ),
              subtitle: Text("Date de debut :${formation['start']}"),
              trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserHome()));
                  }))
        ]);
  }
}
