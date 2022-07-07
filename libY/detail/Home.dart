import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> ships = [
    "  Problem Solving  ",
    "  JAva Programing  ",
    "  Object-Oriented Programming (OOP)  ",
    "Eclipse (Software)",
    "computer Programing"
  ];
  List<dynamic> progress = [
    {"number": 5, "poucent": 82.62},
    {"number": 4, "poucent": 14.81},
    {"number": 3, "poucent": 1.70},
    {"number": 2, "poucent": 0.28},
    {"number": 1, "poucent": 0.56},
  ];
  List<dynamic> menu = [
    {
      "title": "Date limites Flexibles",
      "description":
          "Reinitialiser les date limite selon votre disponibilite Reinitialiser les date limite selon votre disponibilite",
      "icon": Icons.calendar_month
    },
    {
      "title": "Date limites Flexibles",
      "description": "Reinitialiser les date limite selon votre disponibilite",
      "icon": Icons.calendar_month
    },
    {
      "title": "Date limites Flexibles",
      "description": "Reinitialiser les date limite selon votre disponibilite",
      "icon": Icons.calendar_month
    },
    {
      "title": "Date limites Flexibles",
      "description": "Reinitialiser les date limite selon votre disponibilite",
      "icon": Icons.calendar_month
    }
  ];
  int index = 1;
  Widget enseignant(context) {
    final heigth = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Expanded(
        flex: 5,
        child: Column(
          children: [
            SizedBox(height: heigth * 0.15),
            Divider(
              color: Colors.black26,
              height: 5,
            ),
            SizedBox(height: heigth * 0.1),
            Text("Programme de cours: ce que vous apprendriez dans ce cours",
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            SizedBox(
              width: 8.0,
            ),
            Text("evaluation du contenu  97%  (7 453 ) evaluation",
                style: TextStyle(color: Colors.black, fontSize: 12)),
            SizedBox(height: heigth * 0.15),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      height: heigth * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Semaine",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18)),
                          Text("1",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25)),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Container(
                      height: heigth * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.amberAccent,
                            ),
                            title: Text(" 5 heures pour terminer",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12)),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("      Initiatiation a la programation",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18)),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                              "      Initiatiation a la programation Initiatiation a la programation Initiatiation a la programation",
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14)),
                          ListTile(
                              trailing: Text("Voir tout",
                                  style: TextStyle(color: Colors.blue)),
                              title: Text(
                                  " 8 video ( total 75 min ) 11 lecture ,2 quiz",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12)),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                              )),
                        ],
                      ),
                    ))
              ],
            )
          ],
        ));
  }

  Widget apropos(context) {
    final heigth = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;

    return Expanded(
        flex: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: widht * .05, right: widht * .05, top: heigth * 0.05),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("A propos De ce Cours",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text("16280 Consultation recentes",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: heigth * 0.05),
                      Text(
                          "ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ...",
                          style:
                              TextStyle(color: Colors.black87, fontSize: 11)),
                      SizedBox(height: heigth * 0.03),
                      Text(
                          "ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ce Cour est initié au base de donné  de la programmation  en utilisant le language java : varialbe,fonction,boucle ",
                          maxLines: 4,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 11)),
                      SizedBox(
                        height: heigth * 0.1,
                      ),
                      Container(
                        width: widht * 0.35,
                        height: heigth * 0.25,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: 2)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("COMPETENCE QUE VOUS AQUERRIER",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  3,
                                  (index) => Container(
                                        alignment: Alignment.center,
                                        height: heigth * 0.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color.fromARGB(
                                                255, 241, 240, 240)),
                                        child: Text(ships[index],
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 11)),
                                      )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: heigth * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color:
                                          Color.fromARGB(255, 241, 240, 240)),
                                  child: Text("  Eclipse (Software)  ",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 11)),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: heigth * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromRGBO(241, 240, 240, 1)),
                                  child: Text("  computer Programing  ",
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 11)),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: List.generate(
                        menu.length,
                        (index) => ListTile(
                              subtitle: Text(menu[index]["description"],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                  )),
                              title: Text(menu[index]["title"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600)),
                              leading: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 224, 224, 224),
                                child: Icon(Icons.network_cell,
                                    size: 17, color: Colors.red),
                              ),
                            )),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget body(index, context) {
    switch (index) {
      case 1:
        return apropos(context);
        break;
      case 2:
        return enseignant(context);
        break;
      default:
        return avis(context);
    }
  }

  Widget avis(context) {
    final heigth = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;
    return Expanded(
        flex: 5,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: heigth * 0.15,
                        ),
                        Text("Avis",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w600)),
                        Container(
                          alignment: Alignment.center,
                          // color: Colors.black,
                          width: widht * 0.2,
                          height: heigth * 0.15,
                          child: Row(
                            children: [
                              Text("4.8",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: List.generate(
                                        5,
                                        (index) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 17,
                                            )),
                                  ),
                                  Text("120 avis",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: heigth * 0.3,
                          width: widht * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                progress.length,
                                (index) => ListTile(
                                      leading: Text(
                                          "${progress[index]["number"]}  Stars",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      title: LinearProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        color: Colors.amber,
                                        value: progress[index]["poucent"],
                                        semanticsLabel: progress[index]
                                                ["poucent"]
                                            .toString(),
                                        minHeight: 8.0,
                                      ),
                                      trailing: Text(
                                          "${progress[index]["poucent"]} %",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    )),
                          ),
                        )
                      ]),
                )),
            Expanded(flex: 3, child: Container()),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final widht = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        height: heigth,
        width: widht,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: heigth * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black38, width: 2))),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: widht * .05,
                        ),
                        InkWell(
                          onTap: (() {
                            setState(() {
                              index = 1;
                              print(index);
                            });
                          }),
                          child: Text("A propos ",
                              style: TextStyle(
                                  color: index == 1
                                      ? Colors.blue
                                      : Colors.black87)),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: (() {
                            setState(() {
                              index = 2;
                              print(index);
                            });
                          }),
                          child: Text("Enseignants",
                              style: TextStyle(
                                  color: index == 2
                                      ? Colors.blue
                                      : Colors.black87)),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: (() {
                            setState(() {
                              index = 3;
                              print(index);
                            });
                          }),
                          child: Text("Programme de cours",
                              style: TextStyle(
                                  color: index == 3
                                      ? Colors.blue
                                      : Colors.black87)),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: (() {
                            setState(() {
                              index = 4;
                              print(index);
                            });
                          }),
                          child: Text("Avis",
                              style: TextStyle(
                                  color: index == 4
                                      ? Colors.blue
                                      : Colors.black87)),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text("Programme de cours",
                            style: TextStyle(color: Colors.black87)),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text("Option d inscription",
                            style: TextStyle(color: Colors.black87)),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text("Faq", style: TextStyle(color: Colors.black87))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body(index, context)
        ]),
      ),
    );
  }
}
