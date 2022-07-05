// ignore_for_file: file_names, non_constant_identifier_names

import 'package:data_sc_tester/FormationClass.dart';
import 'package:data_sc_tester/api/Formation.dart';
import 'package:data_sc_tester/skills/CustomCardView.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: slash_for_doc_comments
/**
 *  C'est dans cette page qu'on propose à un u_tillisateur nouvellement inscrit de 
 *  souscrire à  sa premiere formation ! d'ou le nom : get Started
 */

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

double width = 0, height = 0, margin = 10;
double optionCardWidth = 400.0, optionCardSpacing = 10.0;

List<Map> DATA = [
  {
    "title": "Data Analyst",
    "description": "Ce module est tres important",
    "image": "../../assets/images/3.jpg",
  },
  {
    "title": "Data Mining",
    "description": "Ce module est tres important\n\n\n Viens le visiter",
    "image": "../../assets/images/2.jpg",
  },
  {
    "title": "Data Mining",
    "description": "Ce module est tres important\n\n\n Viens le visiter",
    "image": "../../assets/images/3.jpg",
  }
];

class _GetStartedState extends State<GetStarted> {
  FormationBoss formationService = FormationBoss();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Bienvenue !',
      home: Scaffold(
          body: FutureBuilder<List>(
        future: formationService.getAllFormation(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, i) {
                return CustomCardView(
                        formation_id: 'ML01',
                        title: snapshot.data![i]["titre"],
                        description: snapshot.data![i]["description"],
                        image: snapshot.data![i]["competence"])
                    .cardview(context);
              },
            );
          } else {
            return Text("No data");
          }
        },
      )

          //     CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //             expandedHeight: height * 0.1,
          //             pinned: true,
          //             floating: true,
          //             elevation: 10,
          //             //expandedHeight: 250.0,
          //             flexibleSpace: Container(
          //               height: height * 0.12,
          //               width: double.infinity,
          //               child: Container(
          //                   padding: EdgeInsets.only(top: 0),
          //                   child: Center(child: Text("A Quel cours aimeriez vous souscrire ?", style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),))),
          //             )),
          //         SliverList(delegate: SliverChildListDelegate(GetStartedBody(context))),
          //   ],
          // )

          ),
      debugShowCheckedModeBanner: false,
    );
  }

  List<Widget> GetStartedBody(BuildContext buildContext) {
    return [
      GridView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: optionCardWidth,
        ),
        children: [],
      )
    ];
  }
}
/**A mettre dans Children */
// for (Map data in DATA)
// CustomCardView(
//         formation_id: 'ML01',
//         title: data["title"],
//         description: data["description"],
//         image: data["image"])
//     .cardview(buildContext),
