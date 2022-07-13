import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'UserPage.dart';
import 'api/CallApi.dart';

class Transaction extends StatefulWidget {
  final String url;
  final Map<String, dynamic> info;
  const Transaction({Key? key, required this.url, required this.info})
      : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List states = ['Echec', 'En attente', 'Réussie'];
  var state = 1;

  updateTransactionStatus() {
    setState(() {
      state = 1;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    js.context.callMethod('open', [widget.url, '_blank']);

    Toaster();
    // updateTransactionStatus();
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void Toaster() {
    Fluttertoast.showToast(msg: "Init transaction", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, fontSize: 24);
  }

  bro() {
    setState(() {
      state = state == 2 ? 0 : state++;
    });
  }

  List<String> status = ['FAILED', 'PENDING', 'SUCCESS'];

  yo(BuildContext context) {
    Timer(const Duration(seconds: 5), (() async {
      var formation_id = widget.info['formation_id'];
      var transaction_id = widget.info['transaction_id'];

      print(formation_id);
      var response = await CallApi()
          .postData(widget.info, "payment/status/$formation_id/$transaction_id");

      print(response.body);
      var body = json.decode(response.body);
      print(body['status']);

      if (body['status'] == 400) Navigator.of(context).pop();
      //TODO : ajouter un toast dans Presentation, pour dire echec, veuillez reessayer

      setState(() {
        state = status.indexOf(body['status']);
      });

      if (state == 0) {
        Navigator.of(context).pop();
        //TODO : ajouter un toast dans Presentation, pour dire echec, avec la reaison de l'echec (api)

        //TOD0: reccuperer la raison de l'echec
      }
      if (state == 2) {
        //Success


        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserHome(
                      a: 1,
                    )));
      }

      yo(context);
    }));
  }

  @override
  Widget build(BuildContext context) {
    Toaster();
    // Scaffold.of(context).showSnackBar(SnackBar(content: const Text("data")));
    yo(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SpinKitSpinningLines(
            color: Colors.blueAccent,
            size: 100,
          ),
          Text(
            "Statut de votre paiement ${states[state]}",
            style:
                TextStyle(color: Colors.black, decoration: TextDecoration.none),
          ),

          // Text(widget.url)
        ],
      ),
    );
  }
}
