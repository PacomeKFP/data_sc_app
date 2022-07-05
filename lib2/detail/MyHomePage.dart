// import 'package:flutter/material.dart';
// import 'package:data_sc_tester/home.dart';

// import '../skills/home_functions.dart';
// import '../skills/home_user_widget.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
// //==============CONTROLERS IMPLEMENTATION============================
// final _userControllers = {
//   'searchBar': TextEditingController(),
// };
// void dispose() {
//   _userControllers['searchBar']?.dispose();
// }

// //=====================================================================
// var a, b;

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final heigth = MediaQuery.of(context).size.height;
//     final widht = MediaQuery.of(context).size.width;
//     a = heigth;
//     b = widht;
//     return Scaffold(
//         body: CustomScrollView(
//       slivers: [
//         SliverAppBar(
//             expandedHeight: heigth * 0.08,
//             pinned: true,
//             floating: true,
//             elevation: 10,
//             //expandedHeight: 250.0,
//             flexibleSpace: Container(
//               height: heigth * 0.1,
//               width: double.infinity,
//               child: ProfileBar(heigth: heigth, widht: widht),
//             )

//             //FlexibleSpaceBar(title: ProfileBar(heigth: heigth, widht: widht), heig),
//             ),
//         SliverList(delegate: SliverChildListDelegate(children()))
//       ],
//     ));
//   }
// }

// List<Widget> children() {
//   List<Widget> listItems = [];
//   listItems.add(SecondBar(widht: a, heigth: b));
//   listItems.add(Page(widht: a, heigth: b));
//   return listItems;
// }

// class Page extends StatelessWidget {
//   const Page({
//     Key? key,
//     required this.heigth,
//     required this.widht,
//   }) : super(key: key);

//   final double heigth;
//   final double widht;

//   @override
//   Widget build(BuildContext context) {
//     return Container(height: heigth, width: widht, child: Home());
//   }
// }

// class SecondBar extends StatelessWidget {
//   const SecondBar({
//     Key? key,
//     required this.widht,
//     required this.heigth,
//   }) : super(key: key);

//   final double widht;
//   final double heigth;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: heigth * 0.1,
//       color: Colors.blue,
//       child: Row(children: [
//         SizedBox(width: widht * .05),
//         Expanded(
//             flex: 2,
//             child: Container(
//               alignment: Alignment.topLeft,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text("Bienvenue !", style: TextStyle(fontSize: 26))
//                 ],
//               ),
//             )),
//         Expanded(
//             flex: 1,
//             child: Container(
//                 alignment: Alignment.topLeft,
//                 padding: EdgeInsets.only(top: 0, left: widht * .05, right: 0),
//                 height: heigth * 0.4,
//                 child: Text("EPFL",
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 30,
//                         fontWeight: FontWeight.w600))))
//       ]),
//     );
//   }
// }

// class ProfileBar extends StatelessWidget {
//   const ProfileBar({
//     Key? key,
//     required this.heigth,
//     required this.widht,
//   }) : super(key: key);

//   final double heigth;
//   final double widht;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Container(
//               alignment: Alignment.center,
//               height: heigth * 0.1,
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(left: 22),
//                     width: widht * 0.3,
//                     child: TextField(
//                       controller: _userControllers['searchBar'],
//                       decoration: InputDecoration(
//                         hintText: 'Recherche',
//                         filled: true,
//                         fillColor: Colors.blueGrey[50],
//                         labelStyle: TextStyle(fontSize: 12),
//                         contentPadding: EdgeInsets.only(left: 30),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blueGrey),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blueGrey),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     color: Colors.blue,
//                     child: IconButton(
//                         onPressed: () {
//                           makeSearch(_userControllers['searchBar']!.text);
//                         },
//                         icon: const Icon(Icons.search,
//                             color: Colors.white, size: 17)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//               flex: 1,
//               child: Container(
//                 height: heigth * .1,
//                 // color: Colors.amber,
//                 alignment: Alignment.centerLeft,

//                 child: UserProfile("Pacome Kengali",
//                     "../assets/images/profil.jpeg"), //prend user id en param
//               ))
//         ],
//       ),
//     );
//   }
// }
