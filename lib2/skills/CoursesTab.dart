import 'package:flutter/material.dart';

class CoursesBloc {
  List<Map<String, dynamic>> courses; //listes des cours avec leurs details
  Function(String key, int object) pressEvent;
  //object 0--> fleches; object 1--> box

  CoursesBloc(
      {
      required this.courses,
      required this.pressEvent});
  

  Widget getCoursesBloc({String inView = "-" /*id du cours affiché*/,required Map<String, bool> box,required Widget Function(String titleKey, int degree, int course_index) bloc}) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
      for (Map<String, dynamic> course in courses)
        ListTile(
          title: Text("${course['name'].toString()} "),
          
          leading: IconButton(
              onPressed: () => pressEvent(course['cours_id'].toString(), 0),
              icon: inView == course['cours_id'].toString()
                  ? const Icon(Icons.keyboard_double_arrow_down_rounded)
                  : const Icon(Icons.keyboard_double_arrow_right_rounded)),

          trailing: IconButton(
              onPressed: () => pressEvent(course['cours_id'].toString(), 1),
              icon: box[course["cours_id"].toString()] == true 
                  ? const Icon(Icons.radio_button_checked_rounded, color: Colors.green,)
                  : const Icon(Icons.radio_button_off_rounded, color: Colors.redAccent,)),

          subtitle: inView == course["cours_id"] ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bloc('description', 1, courses.indexOf(course)),
              bloc('price', 1, courses.indexOf(course))
            ],
          ) : SizedBox()
        ),
    ]);
  }
}
