    // ignore_for_file: non_constant_identifier_names

    import 'dart:convert';
    import 'package:http/http.dart' as http;
    import 'package:shared_preferences/shared_preferences.dart';

    class CallApi {
    final String baseUrl = "http://elearning.togettechinov.com/datapp/public/";

    AuthenticateUser(data) async {
        var fullUrl = '${baseUrl}login' ;
        final prefs = await SharedPreferences.getInstance();
        var T = prefs.getString('token');
        return await http.post(Uri.parse(fullUrl),
            body: jsonEncode(data), //Corps de la requette
            headers: _setHeaders(T) //gener ation du header
            );
    }
    UnAuthenticateUser() async {
        var fullUrl = '${baseUrl}logout?' ;
        final prefs = await SharedPreferences.getInstance();
        var T = prefs.getString('token');
        print(_setHeaders(T));
        return await http.post(Uri.parse(fullUrl),
            headers: _setHeaders(T) //gener ation du header
            );
    }
    postData(data, apiUrl) async {
        var fullUrl = baseUrl + apiUrl  ;
        final prefs = await SharedPreferences.getInstance();
        var T = prefs.getString('token');
        return await http.post(Uri.parse(fullUrl),
            body: jsonEncode(data), //Corps de la requette
            headers: _setHeaders(T) //gener ation du header
            );
    }

    getData(apiUrl) async {
        //pour les requettes en get !
        var fullUrl = baseUrl + apiUrl;
        final prefs = await SharedPreferences.getInstance();
        var T = prefs.getString('token');
        return await http.get(Uri.parse(fullUrl),
            headers:  _setHeaders(T) //gener ation du header
            );
    }

    _setHeaders(token) =>   {
                'Content-type': 'application/json',
                'Accept': 'application/json',
                "Authorization": "Bearer $token",
        };

    }
