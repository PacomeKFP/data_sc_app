// ignore_for_file: non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, use_build_context_synchronously
import 'dart:convert';

import 'package:data_sc_tester/Transaction.dart';
import 'package:data_sc_tester/UserPage.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/skills/CoursesTab.dart';
import 'package:data_sc_tester/skills/ToastWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const PresentAndBuyFormation(
    formation_id: 'No formation Selected',
    formation: {},
  ));
}

double height = 0, width = 0;

class PresentAndBuyFormation extends StatefulWidget {
  final String formation_id;
  final Map formation;
  const PresentAndBuyFormation(
      {Key? key, required this.formation_id, required this.formation})
      : super(key: key);

  @override
  State<PresentAndBuyFormation> createState() => _PresentAndBuyFormationState();
}

class _PresentAndBuyFormationState extends State<PresentAndBuyFormation> {
  /// Ici on va reccuperer les in formations de la formlation ainsi que de chaque
  /// cours qu'il contient et le stocker dans formation

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
                  : (double.parse(course['montant'].toString())));
      });
      if (allBuyed) montantTotal = 50000; //s'il achete tous on donee à 50k
    });
  }

  //================================

  Future<List> getCourses(data) async {
    var response = await CallApi()
        .postData(data, 'formation/${widget.formation_id}/cours');

    print(response.body['message']);

    updateMontantTotal();

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
        title: "DC - ${widget.formation['formation']}",
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Colors.lightBlueAccent,
                expandedHeight: height * 0.1,
                pinned: true,
                floating: true,
                elevation: 10,
                //expandedHeight: 250.0,
                flexibleSpace: Container(
                  alignment: Alignment.center,
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

      _bloc('description', 0, -1), _bloc('debouches', 0, -1),
      _bloc('employeur', 0, -1),

      //On passe à present aux cours de la formation
      FutureBuilder<List>(
          future: getCourses(widget.formation_id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              courses = snapshot.data![0]['message'];
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
              children: const [
                SpinKitFoldingCube(
                  color: Colors.blue,
                  size: 100,
                ),
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
              onPressed: () => _buyCourse(context),
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: const Text("Finaliser l'achat !")),
        ],
      ),
      const SizedBox(height: 50)
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
        ? content = widget.formation[titleKey].toString()
        : content = courses[course_index][titleKey].toString();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
                titleKey == 'debouches' ? "Débouchées" : Capitalise(titleKey)),
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
          leading: IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: ((context) => UserHome()))),
          ),
          title: Text(widget.formation['titre'],
              style: const TextStyle(fontSize: 24)),
          subtitle: Text("Date de debut :${widget.formation['date_debut']}"),
          trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart_rounded),
              onPressed: () => _buyCourse(context)))
    ]);
  }

  void _buyCourse(BuildContext context) async {
    var response =
        await CallApi().postData("data", "payment/init/$montantTotal");

    var formation_id = widget.formation_id;
    var transaction_id = json.decode(response.body)['transaction_id'];

    print(response.body);

    var resp = await CallApi()
        .postData("data", "payment/status/$formation_id/$transaction_id");

    if (json.decode(resp.body)['status'] == 400) {
      print(json.decode(resp.body));
      makeToast(
          msg: "Une Erreur est survenue lors du paiement", context: context);
    } else {
      print(response.body);
      print("\n\n");
      print(resp.body);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Transaction(
                    url: json.decode(response.body)['link'].toString(),
                    info: {
                      'transaction_id':
                          json.decode(response.body)['transaction_id'],
                      'formation_id': widget.formation_id,
                      'cours': CoursAchete,
                    },
                  )));
    }
  }
}
