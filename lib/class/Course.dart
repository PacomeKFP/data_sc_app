import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../api/CallApi.dart';

class Course {
  final String cours_id;
  final String formation_id;
  final String titre;
  final String objectif;
  final String presentation;
  final String apport_direct;
  final String application;
  final String activite;
  final String evaluation;
  final String support_pdf;
  final double montant;
  final String date_debut;
  final String created_at;
  final String updated_at;

  Course({
    required this.cours_id,
    required this.formation_id,
    required this.titre,
    required this.objectif,
    required this.presentation,
    required this.apport_direct,
    required this.application,
    required this.activite,
    required this.evaluation,
    required this.support_pdf,
    required this.montant,
    required this.date_debut,
    required this.created_at,
    required this.updated_at,
  });

  factory Course.fromJson(dynamic json) {
    return Course(
      cours_id: json["cours_id"] as String,
      formation_id: json["formation_id"] as String,
      titre: json["titre"] as String,
      objectif: json["objectif"] as String,
      presentation: json["presentation"] as String,
      apport_direct: json["apport_direct"] as String,
      application: json["application"] as String,
      activite: json["activite"] as String,
      evaluation: json["evaluation"] as String,
      support_pdf: json["support_pdf"] as String,
      montant: json["montant"] as double,
      date_debut: json["date_debut"] as String,
      created_at: json["created_at"] as String,
      updated_at: json["updated_at"] as String,
    );
  }
  String getObj(String titleKey) {
    if (titleKey == "formation_id") return formation_id;
    return date_debut;
  }
}

List<Course> parseCourses(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Course>((json) => Course.fromJson(json)).toList();
}

Future<List<Course>> fetchCourses(data, String formation_id) async {
  var response =
      await CallApi().postData(data, 'formation/${formation_id}/cours');
  
  print(parseCourses(response.body['message'] as String).toString());
  // return parseCourses(response.body['message']);
  return compute(parseCourses, response.body['message'].toString());
}
