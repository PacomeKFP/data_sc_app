// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CoursesBloc {
  List<dynamic> courses; //listes des cours avec leurs details
  Function(String key) pressEvent;
  //object 0--> fleches; object 1--> box

  CoursesBloc(
      {required this.courses, required this.pressEvent});

  Widget getCoursesBloc(
      {String inView = "" /*id du cours affiché*/,
      required void Function(String key, bool val) changeTo,
      required Map<String, bool> box,
      required Widget Function(String titleKey, int degree, int course_index)
          bloc}) {


    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (Map<String, dynamic> course in courses)
        ListTile(
            title: Text("${course['titre'].toString()} "),
            
            leading: IconButton(
                onPressed: () => pressEvent(course['cours_id'].toString()),
                icon: inView == course['cours_id'].toString()
                    ? const Icon(Icons.keyboard_double_arrow_down_rounded)
                    : const Icon(Icons.keyboard_double_arrow_right_rounded)),

            trailing: Switch(
              onChanged: (e) => {changeTo(course['cours_id'].toString(), e)},
              value: box[course["cours_id"].toString()] == null
                  ? true
                  : box[course["cours_id"].toString()] as bool,
              activeColor: Color.fromARGB(255, 107, 255, 112),
              activeTrackColor: Colors.amber,
              inactiveTrackColor: Colors.redAccent,
            ),

            subtitle: inView == course["cours_id"]
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bloc('formation_id', 1, courses.indexOf(course)),
                      bloc('date_debut', 1, courses.indexOf(course)),
                    ],
                  )
                : const SizedBox(width: 0, height: 0,)),
    ]);
  }
}
