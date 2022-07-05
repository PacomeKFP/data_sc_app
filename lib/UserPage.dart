// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:data_sc_tester/FormationClass.dart';
import 'package:data_sc_tester/GetStarted.dart';
import 'package:data_sc_tester/main.dart';
import 'package:data_sc_tester/skills/CustomCardView.dart';
import 'package:data_sc_tester/skills/HomeFunctions.dart';
import 'package:data_sc_tester/skills/HomeUserWidgets.dart';
import 'package:data_sc_tester/skills/TabMenu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'api/CallApi.dart';

void main() {
  runApp(const UserHome());
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}
//==============CONTROLERS IMPLEMENTATION============================

List<Map> DATA = [];

final _userControllers = {
  'searchBar': TextEditingController(),
};

void dispose() {
  _userControllers['searchBar']?.dispose();
}

double optionCardWidth = 800.0, optionCardSpacing = 10.0;

Future<List<Formation>> fetchFormation() async {
  final response = await http.get(
      Uri.parse('https://elearning.togettechinov.com/app/public/formation'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var articles = <Formation>[];
    articles = articles.map((model) => Formation.fromJson(model)).toList();
    return articles;
    // return Formation.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Echec du chargement des Formations');
  }
}

//=====================================================================
class _UserHomeState extends State<UserHome> {
  late Future<List<Formation>> formations;
  var test;

  int index = 0;
  var user;
  double height = 0, width = 0;
  @override
  void initState() {
    super.initState();
    //print(formations.length);
    formations = fetchFormation();
  }

  Widget Test() {
    return FutureBuilder<List<Formation>>(
      future: formations,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("Snapshoot");
          print(snapshot as String);
          return Text(snapshot.data![0].titre);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _getUser();
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
                expandedHeight: height * 0.1,
                pinned: true,
                floating: true,
                elevation: 10,
                //expandedHeight: 250.0,
                flexibleSpace: Container(
                  height: height * 0.12,
                  width: double.infinity,
                  child: ProfileBar(),
                )),
            SliverList(delegate: SliverChildListDelegate(children())),
          ],
        )));
  }

  Widget Body(index, context) {
    switch (index) {
      case 0:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 8),
          child: Center(child: Acceuil(context)),
        );
      case 1:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 8),
          child: Center(child: MesFormations(context, 1)),
        ); //liste Formations en cours
      case 2:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 8),
          child: Center(child: MesFormations(context, 2)),
        ); //liste Formations terminées
      default:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 8),
          child: Center(child: Acceuil(context)),
        );
    }
  }

  Map tabManager = {
    'test1': true,
    'test2': false
  }; //toujours afficher la 1ere formation
  String courseKeyToDisplay =
      "course1"; //on prendra le 1er cours de la premiere formation

  void tabPress(String key, int degree) {
    if (degree == 0) {
      //Click sur une formation
      setState(() {
        //On roule toutes les formations ouvertes
        bool callerState = tabManager[key];
        tabManager.forEach((key, value) {
          tabManager[key] = false;
        });
        tabManager[key] = !callerState; //On ouvre la formation en question
      });
    }

    if (degree == 1) {
      //Cas où on clique sur un cours
      setState(() {
        courseKeyToDisplay = key;
      });
    }
  }

  Widget MesFormations(BuildContext context, int index) {
    String MesFormations = index == 1 ? "En cours" : "Terminée";

    bool isEmpty = true; //pas de formations renvoye
    //permet de savoir si il y a les cours dans la categorie
    // C'est à dire : true is il n'y a aucune formation à  afficher, false sinon

    String message; //Message obtenu de la requette
    message = isEmpty == false
        ? "Aucune formation $MesFormations "
        : "Formations $MesFormations";

    if (isEmpty) {
      return Container(
        width: width * 7 / 8,
        height: height * 0.88,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                //menu
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabMenu(tab: {
                        'key': 'test1',
                        'name': 'Machine Learning'
                      }, Items: [
                        {'key': 'course1', 'name': 'Cours 1'},
                        {'key': 'course2', 'name': 'Cours 2'},
                        {'key': 'course3', 'name': 'Cours 3'},
                        {'key': 'course4', 'name': 'Cours 4'},
                        {'key': 'course5', 'name': 'Cours 5'},
                        {'key': 'course6', 'name': 'Cours 6'}
                      ]).getTab(
                        isActive: tabManager['test1'],
                        pressEvent: tabPress,
                      ),
                      TabMenu(tab: {
                        'key': 'test2',
                        'name': 'Deep Learning'
                      }, Items: [
                        {'key': 'course1', 'name': 'Cours 1'},
                        {'key': 'course2', 'name': 'Cours 2'},
                        {'key': 'course3', 'name': 'Cours 3'},
                        {'key': 'course4', 'name': 'Cours 4'}
                      ]).getTab(
                        isActive: tabManager['test2'],
                        pressEvent: tabPress,
                      ),
                    ],
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: CourseDisplayer(buildContext: context),
              ),
            )
          ],
        ),
      );
    }
    //
    else {
      //Page vide
      return Container(
        //Rien à afficher
        color: Colors.white,
        width: width * 7 / 8,
        height: height * 0.88,
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 32,
              color: Colors.black12,
              backgroundColor: Color.fromARGB(208, 255, 191, 0)),
        ),
      );
    }
  }

  Widget CourseDisplayer({required BuildContext buildContext}) {
    /**
        * Ici on genere les données de la formation en se basant sur son id(formation_id)
         */
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [Text(courseKeyToDisplay)],
        ));
  }

  Widget Acceuil(BuildContext context) {
    return Center(child: Lister(buildContext: context));
  }

  Widget Lister(
      {required BuildContext buildContext, String trainingType = "all"}) {
    /**On va d'abord faire une requette pour reccuperer les formations à afficher
     * Il faudra faire la recherche des données en fontion du trainingType:
     *  -all : toutes les formation, priorité au nouvelles  (page d'acceuil),
     *  -En cours/pending : pour les formations en cours
     *  -fini/finished : pour les formations terminées
     */

    return Container(
        height: height * 0.88,
        child: FutureBuilder<List<Formation>>(
          future: formations,
          builder: (context, snapshot) {
            if (snapshot.hasData) {

              print("Snapshoot");
              print(snapshot as String);
              return Text(snapshot.data![0].titre);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }

  Widget Menu() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          _menuItem(
            title: "Page d'Acceuil",
            isActive: index == 0 ? true : false,
            value: 0,
          ),
          _menuItem(
            title: "En cours",
            isActive: index == 1 ? true : false,
            value: 1,
          ),
          _menuItem(
            title: "Terminé",
            isActive: index == 2 ? true : false,
            value: 2,
          ),
        ],
      ),
    );
  }

  List<Widget> children() {
    List<Widget> listItems = [];
    //listItems.add(SecondBar());
    listItems.add(Page());
    return listItems;
  }

  Widget Page() {
    return Container(
        height: height,
        width: width,
        color: Color.fromARGB(255, 211, 211, 211),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Menu(),
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: width / 8)),
            const SizedBox(height: 10),
            Container(
              child: Body(index, context),
            )
          ],
        ));
  }

  Widget SecondBar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width / 8, vertical: height * 0.1 / 6),
      height: height * 0.15,
      color: Colors.blue,
      child: Row(children: [
        Expanded(
            child: Container(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Bienvenue !", style: TextStyle(fontSize: 26)),
            ],
          ),
        )),
        Expanded(
            child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 0, left: width * .05, right: 0),
                height: height * 0.4,
                child: Container(
                  color: Colors.white38,
                )))
      ]),
    );
  }

  Widget ProfileBar() {
    var name;
    _loadInformations() async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         setState(() {
           name = prefs.getString('name');
         });
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width / 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: height * 0.08,
              child: Row(
                children: [
                  Container(
                    width: width * 0.3,
                    child: TextField(
                      controller: _userControllers['searchBar'],
                      decoration: InputDecoration(
                        hintText: 'Recherche',
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.blue,
                        child: IconButton(
                            onPressed: () {
                              makeSearch(_userControllers['searchBar']!.text);
                            },
                            icon: const Icon(Icons.search,
                                color: Colors.white, size: 14)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
                    height: height * 0.08,
                    child: OutlinedButton(
                      onPressed: () => {print('logout')}, //_logout
                      child: Text("Se deconnecter"),
                    ),
                  ),
                  Container(
                    height: height * .08,
                    // color: Colors.amber,

                    child: UserProfile(name,
                        "../assets/images/profil.jpeg"), //prend user id en param
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget _menuItem(
      {String title = 'Title Menu', isActive = false, int value = 0}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(),
            ),
            onPressed: () {
              if (isActive == false) {
                setState(() {
                  index = value;
                });
              }
            },
            child: Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          SizedBox(height: 6),
          isActive
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
  //===========================================================================================
  //===========================================================================================
  //===========================================================================================

  _getUser() async {
    var res = await CallApi().postData({}, 'user-auth-details');
    var body = json.decode(res.body);
    print(body);
    if (await body['status'] == 200) {
      setState(() {
        user = body['user'];
      });
      print(user['user']);
    }
  }

  _logout() async {
    var res = await CallApi().postData({}, 'logout');
    var body = json.decode(res.body);
    print(body);
    if (await body['status'] == 200) {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => MyAppView()));
    } else {
      print('error');
    }
  }
}
