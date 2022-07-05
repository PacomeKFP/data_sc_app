// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:data_sc_tester/GetStarted.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/skills/CustomCardView.dart';
import 'package:data_sc_tester/skills/HomeFunctions.dart';
import 'package:data_sc_tester/skills/HomeUserWidgets.dart';
import 'package:data_sc_tester/skills/TabMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

void main() {
  runApp(const UserHome());
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}
//==============CONTROLERS IMPLEMENTATION============================

List<Map> DATA = [
  {
    "title": "Data Analyst",
    "description": "Ce module est tres important",
    "image": "../../assets/images/3.jpg",
  },
  {
    "title": "Data Mining",
    "description": "Ce module est tres important",
    "image": "../../assets/images/2.jpg",
  },
  {
    "title": "Data Mining",
    "description": "Ce module est tres important",
    "image": "../../assets/images/1.jpg",
  },
  {
    "title": "Data Mining",
    "description": "Ce module est tres important",
    "image": "../../assets/images/2.jpg",
  },
  {
    "title": "Data Mining",
    "description": "Ce module est tres important",
    "image": "../../assets/images/3.jpg",
  },
];

final _userControllers = {
  'searchBar': TextEditingController(),
};

void dispose() {
  _userControllers['searchBar']?.dispose();
}

double optionCardWidth = 800.0, optionCardSpacing = 10.0;

//=====================================================================

class _UserHomeState extends State<UserHome> {
  int index = 0;
  var NameUser;
  double height = 0, width = 0;
  @override
  void initState() {
    NameUser = '';
    _getNameUser();
    _all_formations();
    super.initState();
  }

  _getNameUser() async {
    final prefs = await SharedPreferences.getInstance();
    var name = prefs.getString('name');
    setState(() {
      NameUser = name;
    });
  }

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
      {required BuildContext buildContext, String trainingType = "all", data}) {
    /**On va d'abord faire une requette pour reccuperer les formations à afficher
     * Il faudra faire la recherche des données en fontion du trainingType:
     *  -all : toutes les formation, priorité au nouvelles  (page d'acceuil),
     *  -En cours/pending : pour les formations en cours
     *  -fini/finished : pour les formations terminées
     */

    return Container(
      height: height * 0.88,
      child: FutureBuilder<List>(
          future: _all_formations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var formations = snapshot.data![0]['formations'];
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 400,
                  ),
                  itemCount: snapshot.data![0]['formations'].length,
                  itemBuilder: (BuildContext ctx, index) {
                    return CustomCardView(
                            formation_id: 'form $index',
                            title: formations[index]["titre"],
                            description: formations[index]["debouches"],
                            image: DATA[index]["image"])
                        .cardview(buildContext);
                  });
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              );
            }
          }),
    );
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
          mainAxisSize: MainAxisSize.max,
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


  Widget ProfileBar() {
    return Container(
      padding: MediaQuery.of(context).size.width > 720
          ? EdgeInsets.symmetric(horizontal: width / 8)
          : EdgeInsets.symmetric(horizontal: 0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: height * 0.08,
            child: Row(
              children: [
                Container(
                  width: width * 0.3,
                  child: TextField(
                    autocorrect: true,
                    controller: _userControllers['searchBar'],
                    decoration: InputDecoration(
                      hintText: 'Recherche',
                      filled: true,
                      fillColor: Color.fromARGB(127, 253, 253, 253),
                      labelStyle: TextStyle(fontSize: 12),
                      suffixIcon: IconButton(
                          onPressed: () {
                            makeSearch(_userControllers['searchBar']!.text);
                          },
                          icon: const Icon(Icons.search,
                              color: Colors.blue, size: 14)),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: height * 0.08,
                child: IconButton(
                  onPressed: () => {print("Deconnexion")},
                  icon: Icon(Icons.logout_rounded),
                ),
              ),
              Container(
                height: height * .08,
                // color: Colors.amber,

                child: UserProfile(
                    NameUser,
                    "../assets/images/profil.jpeg",
                    ), //prend user id en param
              ),
            ],
          )
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

  _logout() async {
    var res = await CallApi().UnAuthenticateUser();
    var body = json.decode(res.body);
    if (await body['status'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      print(body['message']);
    }
  }

  Future<List> _all_formations() async {
    var res = await CallApi().getData('get-all-formations');
    if (res.statusCode == 200) {
      return [json.decode(res.body)];
    } else {
      return res.body['message'];
    }
  }
}
