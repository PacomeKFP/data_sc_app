import 'dart:convert';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FormationsEnCours extends StatefulWidget {
  BuildContext context;
  FormationsEnCours(BuildContext this.context, {Key? key}) : super(key: key);

  @override
  State<FormationsEnCours> createState() => _FormationsEnCoursState();
}

class _FormationsEnCoursState extends State<FormationsEnCours> {
  List formations = [];
  List listeCours = [];
  String coursAffiche = "";
  List<Widget> courseDisplayer = [];
  bool cour = true;
  bool hasCours = false;
  bool once = true;

  Future<List> getFormationEnCours() async {
    var response = await CallApi().postData('data', 'formation_user');

    if (json.decode(response.body)['status'] != 404) {
      setState(() {
        hasCours = true;
        formations = json.decode(response.body)['formations'];
        for (Map formation in formations) {
          listeCours.addAll(formation['cours']);
        }
      });
      return json.decode(response.body)['formations'];
    }
    cour = false;
    return [404] as Future<List>;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    displayCourse();
    return SizedBox(
        height: height * 0.8,
        width: width * 7 / 8,
        child: Center(
            child: width > 600
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: height * 0.8, child: buildPage(height)),
                      ),
                      Expanded(
                          flex: 3,
                          child: !hasCours
                              ? const SpinKitChasingDots(
                                  color: Colors.lightBlueAccent,
                                  size: 100,
                                )
                              : Container(
                                color: Colors.white,
                                  height: height * 0.8,
                                  child: ListView(children: courseDisplayer),
                                ))
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: height * 0.8, child: buildPage(height)),
                      ),
                      Expanded(
                          flex: 3,
                          child: !hasCours
                              ? const SpinKitChasingDots(
                                  color: Colors.lightBlueAccent,
                                  size: 100,
                                )
                              : Container(
                                color: Colors.white,
                                  height: height * 0.8,
                                  child: ListView(children: courseDisplayer),
                                ))
                    ],
                  )));
  }

  displayCourse() {
    
    int index =
        listeCours.indexWhere((element) => element['cours_id'] == coursAffiche);
    setState(() {
      print("SetsTate  $index ");
      
      if (!cour) {
        
        courseDisplayer = [
          const Text(
            "Vous n'avez encore souscrit à aucun cours",
            style: TextStyle(
                color: Colors.lightBlueAccent,
                backgroundColor: Colors.redAccent,
                fontSize: 34),
          ),
        ];
      }

      if (index >= 0 && index < listeCours.length) {
        if(once && !cour){
          index = 0;
        }
        Map cours = listeCours[index];
        // print(cours);
        courseDisplayer = [
          _bloc("cours_id"),
          _bloc("titre"),
        ];
        // cours.forEach((key, value) => child.add(_bloc(key)));
        print(cours['titre']);
      } else {
        courseDisplayer = [
          const Text(
            "Veuillez choisir un cours à visualiser",
            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 34),
          ),
        ];
      }
    });
  }

  Widget buildPage(height) {
    return FutureBuilder<List>(
        future: getFormationEnCours(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const SpinKitFadingGrid(
              color: Colors.transparent,
              size: 100,
            );
          } else {
            formations = snapshot.data!; //reccuperer les formations
            for (Map formation in formations) {
              listeCours.addAll(formation['cours']);
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: formations.length,
              itemBuilder: ((context, index) => TabP(
                      title: formations[index]['formation'],
                      items: formations[index]['cours'])
                  .getTabBloc(
                      showCourse: (String cours_id) => setState(() {
                            coursAffiche = cours_id;
                          }))),
            );
          }
        }));
  }

  Widget _bloc(String titleKey) {
    String content = 'None';
    int index =
        listeCours.indexWhere((element) => element['cours_id'] == coursAffiche);
    content = listeCours[index][titleKey].toString();

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
}

class TabP {
  String title;
  List items;
  TabP({required this.title, required this.items});

  Widget getTabBloc({required void Function(String key) showCourse}) {
    return ListTile(
      title: Text(title),
      subtitle: Column(
        children: [for (var item in items) txtBtnSpace(showCourse, item)],
      ),
    );
  }

  Widget txtBtnSpace(showCourse, item) {
    return Column(
      children: [
        TextButton(
            onPressed: () => showCourse(item['cours_id']),
            child: Text(
              item['titre'],
              style: TextStyle(color: Colors.lightBlueAccent),
            )),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
