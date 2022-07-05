import 'package:flutter/material.dart';

import '../DescriptionAchatFormation.dart';
import '../Presentation.dart';

class CustomCardView {
  final String formation_id;
  final String title;
  final String description;
  final String image;
  CustomCardView({required this.formation_id, this.title = "", this.description = "", this.image = ""});
  Wrap cardview(BuildContext context) {
    return Wrap(
      children:[Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                child: Center(
                    child: Column(children: [
                  Text(
                    this.title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 3,
                    // width: 3,
                  ),
                  Image.asset(this.image,
                      width: 150, height: 150, fit: BoxFit.fill),
                  SizedBox(
                    height: 3,
                    // width: 3,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => PresentAndBuyFormation(formation_id: formation_id))));
                  }, child: Text('Souscrire')),
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 3,
                    // width: 3,
                  ),
                  Text(this.description),
                ])),
                onTap: () {
                  //Implementer diriger vers la page de presentation du cours
                  //   Navigator.push(context,
                  //     MaterialPageRoute<void>(builder: (context) {
                  //   return MyHomePage();
                  // }));
                },
              )
            ],
          ),
        ),
      ),
    ]

    );
    
  }
}
