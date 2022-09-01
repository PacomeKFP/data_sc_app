// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:data_sc_tester/FormationsEnCours.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/skills/CustomCardView.dart';
import 'package:data_sc_tester/skills/HomeFunctions.dart';
import 'package:data_sc_tester/skills/HomeUserWidgets.dart';
import 'package:data_sc_tester/skills/ToastWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

void main() {
  runApp(UserHome());
}

class UserHome extends StatefulWidget {
  final int a;
  bool toast;
  UserHome({Key? key, this.a = 0, this.toast = false}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}
//==============CONTROLERS IMPLEMENTATION============================

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
  var NameUser = "";
  var link_images = "http://elearning.togettechinov.com/datapp/public/storage/";
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
      NameUser = name!;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (index == 0 && widget.toast) {
        makeToast(msg: 'Bienvenue $NameUser', type: 'info', context: context);
        widget.toast = false;
      }
    });

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        title: '$NameUser - DataClevers',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: CustomScrollView(
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
          ),
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
          child: Center(
              child: FormationsEnCours(
            context,
            key: UniqueKey(),
          )),
        ); //liste Formations en cours

      default:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 8),
          child: Center(child: Acceuil(context)),
        );
    }
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

    return SizedBox(
      height: height * 0.88,
      child: FutureBuilder<List>(
          future: _all_formations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var formations = snapshot.data![0]['formations'];
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 650,
                    maxCrossAxisExtent: 380,
                  ),
                  itemCount: snapshot.data![0]['formations'].length,
                  itemBuilder: (BuildContext ctx, index) {
                    return CustomCardView(
                            completed: formations[index]['inscrit'] ?? false,//il faudra changer ceci
                            formation: formations[index],
                            formation_id: formations[index]["formation_id"],
                            title: formations[index]["titre"],
                            description: formations[index]["debouches"],
                            image: link_images + formations[index]["image"])
                        .cardview(buildContext);
                  });
            } else {
              return const Center(
                  child: SpinKitFoldingCube(
                color: Colors.lightBlue,
                size: 100,
              ));
            }
          }),
    );
  }

  Widget Menu() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          _menuItem(
            title: "Page d'acceuil",
            isActive: index == 0 ? true : false,
            value: 0,
          ),
          _menuItem(
            title: "En cours",
            isActive: index == 1 ? true : false,
            value: 1,
          ),
          /*_menuItem(
            title: "Terminé",
            isActive: index == 2 ? true : false,
            value: 2,
          ),*/
          SizedBox(
            child: IconButton(
              onPressed: () => {_logout()},
              icon: const Icon(Icons.logout_rounded),
            ),
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
        color: const Color.fromARGB(255, 211, 211, 211),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: width / 8),
                child: Menu()),
            const SizedBox(height: 10),
            Container(
              child: Body(index, context),
            )
          ],
        ));
  }

  double get w {
    return width > 600 ? width * 0.5 : width * 0.7;
  }

  Widget ProfileBar() {
    return Container(
      height: height * 0.07,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Container(
              width: w,
              child: TextField(
                autocorrect: true,
                controller: _userControllers['searchBar'],
                decoration: InputDecoration(
                  hintText: 'Recherche',
                  filled: true,
                  fillColor: const Color.fromARGB(127, 253, 253, 253),
                  labelStyle: const TextStyle(fontSize: 12),
                  suffixIcon: IconButton(
                      hoverColor: const Color.fromARGB(126, 208, 208, 240),
                      onPressed: () {
                        makeSearch(_userControllers['searchBar']!.text);
                      },
                      icon: const Icon(Icons.search,
                          color: Colors.blue, size: 20)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: height * .08,
                child: UserProfile(NameUser, "../assets/images/profil.jpeg",
                    width), //prend user id en param
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
          title == "Page d'acceuil"
              ? IconButton(
                  onPressed: () {
                    if (isActive == false) {
                      setState(() {
                        index = value;
                      });
                    }
                  },
                  icon: const Icon(Icons.house_outlined))
              : TextButton(
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
          const SizedBox(height: 6),
          isActive
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                )
              : const SizedBox()
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
    print(json.decode(res.body));
    if (res.statusCode == 200) {
      return [json.decode(res.body)];
    } else {
      return res.body['message'];
    }
  }
}

/*

Future<List> getCourses(data) async {
    var response = await CallApi()
        .postData(data, 'formation/${widget.formation_id}/cours');

    return response.statusCode == 200
        ? [json.decode(response.body)]
        : response.body['message'];
  }

  */
