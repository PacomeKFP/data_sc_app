import 'dart:convert';
import 'package:http/http.dart' as http;

class FormationBoss{
  String baseUrl = "http://elearning.togettechinov.com/app/public/formation/";
  Future<List> getAllFormation() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        print(response.body);
        return jsonDecode(response.body);
      } else {
        return Future.error("Erreur du serveur");
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}