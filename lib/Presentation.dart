import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PresentAndBuyFormation extends StatefulWidget {
  
  final String formation_id;
  const PresentAndBuyFormation({Key? key, required this.formation_id}) : super(key: key);

  @override
  State<PresentAndBuyFormation> createState() => _PresentAndBuyFormationState();
}

double width = 0, height = 0, margin = 10;
double optionCardWidth = 400.0, optionCardSpacing = 10.0;



class _PresentAndBuyFormationState extends State<PresentAndBuyFormation> {
  var page = 0;
  var maxPage = 3;

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
          body: CustomScrollView(
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
                child: Container(
                    padding: EdgeInsets.only(top: 0),
                    child: Center(
                        child: Text(
                      widget.formation_id + " that's the training ",
                      style: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
                    ))),
              )),
          SliverList(
              delegate:
                  SliverChildListDelegate(PresentFormation(widget.formation_id))),
        ],
      )),
      debugShowCheckedModeBanner: false,
    );
  }

  List<Widget> PresentFormation(String formation_id) {
    return [Text("formation")];
  }
}
