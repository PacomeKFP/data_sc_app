// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:data_sc_tester/UserPage.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/skills/CoursesTab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

void main() {
  runApp(const PresentAndBuyFormation(formation_id: 'No formation Selected'));
}

double height = 0, width = 0;

class PresentAndBuyFormation extends StatefulWidget {
  final String formation_id;
  const PresentAndBuyFormation({Key? key, required this.formation_id})
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

  List courses = [];
  Map<String, bool> CoursAchete = {};
  //a pratir de lui on pourra savoir quel cours a eté acheté ou pas
  //il sera utilisé directement pour l'achat

  /*
    Structure--> id_cours : etat (true/false); true s'il prend, fals sinon !
   */

  String courseKeyToDisplay = "";
  double montantTotal = 0;

  void updateMontantTotal() {
    //permet de mettre 0 jour le montant total à payer
    bool allBuyed = true;
    montantTotal = 0;

    setState(() {
      if (CoursAchete
          .isEmpty) //Alors on initialise la liste des cours à acheter
        for (Map<String, dynamic> course in courses)
          CoursAchete[course['cours_id'].toString()] = true;

      CoursAchete.forEach((key, value) {
        if (value == false)
          allBuyed = false;
        else
          for (Map<String, dynamic> course in courses)
            if (course['cours_id'] == key)
              montantTotal += (course['montant'].toString() == ""
                  ? 0
                  : (course['montant'] as double));
      });
      if (allBuyed)

        ///tarif special//reduction de 20%
        montantTotal *= 0.8;
    });
  }

  //================================

  Future<List> getCourses(data) async {
    var response = await CallApi()
        .postData(data, 'formation/${widget.formation_id}/cours');

    return response.statusCode == 200
        ? [json.decode(response.body)]
        : response.body['message'];
  }

  _test(data) async {
    var response = await CallApi().getData('get-all-formations');
    if (response.statusCode == 200) {}
    print(json.decode(response.body));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateMontantTotal();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    print("Id de la formation ${widget.formation_id}\n\n");
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
                backgroundColor: const Color.fromARGB(131, 255, 216, 161),
                expandedHeight: height * 0.1,
                pinned: true,
                floating: true,
                elevation: 10,
                //expandedHeight: 250.0,
                flexibleSpace: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: height * 0.12,
                  width: double.infinity,
                  child: FormationName(context),
                )),
            SliverList(
                delegate: SliverChildListDelegate(DetailsFormation(
                    formation_id: widget.formation_id, context: context))),
          ],
        )));
  }

  List<Widget> DetailsFormation(
      {required String formation_id, required BuildContext context}) {
    /**
Commencer par les details de la formation même puis passer à ceux des cours    * 
     */
    return [
      //Elements descriptifs d'une formation

      _bloc('description', 0, -1), _bloc('debouche', 0, -1),
      _bloc('employeur', 0, -1),

      //On passe à present aux cours de la formation
      FutureBuilder<List>(
          future: getCourses(widget.formation_id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              courses = snapshot.data![0]['message'];
              print(courses);
              return CoursesBloc(
                      courses: courses,
                      pressEvent: (String key) => courseToDisplay(key))
                  .getCoursesBloc(
                      changeTo: (String s, bool e) => courseMarketManager(s, e),
                      inView: courseKeyToDisplay,
                      bloc: _bloc,
                      box: CoursAchete);
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator.adaptive(),
              ],
            );
          }),

      //Boutton de souscripttion avec prix total à payer !
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Prix total : ${montantTotal}F"),
          const SizedBox(width: 1),
          OutlinedButton.icon(
              onPressed: () => print("buy Courses $CoursAchete"),
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: const Text("Finaliser l'achat !"))
        ],
      )
    ];
  }

  void courseMarketManager(String s, bool e) {
    return setState(() {
      //mise à jour la liste des cours à acheter, et du montant à payer
      CoursAchete[s] = e;
      updateMontantTotal();
    });
  }

  void courseToDisplay(String key) {
    return setState(() {
      //mise à jour du cours à afficher, à presenter
      courseKeyToDisplay = courseKeyToDisplay == key ? "" : key;
    });
  }

//=======================================================================================================================================
//=======================================================================================================================================
//=======================================================================================================================================

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
    return Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
      ListTile(
          title: Text(formation['name'], style: const TextStyle(fontSize: 24)),
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
