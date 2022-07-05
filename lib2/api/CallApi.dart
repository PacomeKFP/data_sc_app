import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String baseUrl = "https://elearning.togettechinov.com/app/public/";

  postData(data, apiUrl) async {
    var fullUrl = baseUrl + apiUrl + await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), //Corps de la requette
        headers: _setHeaders() //gener ation du header
        );
  }

  getData(apiUrl) async {
    //pour les requettes en get !
    var fullUrl = baseUrl + apiUrl;
    return await http.get(Uri.parse(fullUrl),
        headers: _setHeaders() //gener ation du header
        );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
