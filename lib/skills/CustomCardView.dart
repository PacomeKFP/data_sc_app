// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../Presentation.dart';

class CustomCardView {
  final String formation_id;
  final String title;
  final String description;
  final String image;
  final Map formation;
  CustomCardView(
      {required this.formation_id, required this.formation, 
      this.title = "",
      this.description = "",
      this.image = ""});
  Wrap cardview(BuildContext context) {
    return Wrap(children: [
      Card(
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
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 3),
                  Image.network(image,
                      width: 150, height: 150, fit: BoxFit.fill),
                  const SizedBox(height: 3),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PresentAndBuyFormation(formation: formation,
                                    formation_id: formation_id))));
                      },
                      child: const Text('Souscrire')),
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  const SizedBox(height: 3),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Text(description.substring(
                        0, description.length < 40 ? description.length : 40)),
                  ),
                ])),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
