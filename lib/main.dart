import 'dart:convert';

import 'package:data_sc_tester/GetStarted.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/main.dart';
import 'package:data_sc_tester/skills/TextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CompleterProfil.dart';
import 'skills/Navigation.dart';
import 'pUserPage.dart';
import 'mobile_ui/MobileMain.dart';

//**
//  CORRESPOND EGALEMENT A LA PAGE DE CONNEXION
// */
void main() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    runApp(
        MaterialApp(
            home: redirectAuth(token)
            )
        );
}

redirectAuth(token){
    if(token == null) {
        return MyApp();
    } else {
        _connectCurrentUser();
        return UserHome();
    }
}
void _connectCurrentUser() async {
        final prefs = await SharedPreferences.getInstance();
        var data = { "email" : prefs.getString('email'), "password" : prefs.getString('password')  };

        var res = await CallApi().AuthenticateUser(data);
        var body = json.decode(res.body);
        if (await body['status'] == 200) {
        print('connecter');
        } else {

        print(body['message']);
        }
    }

class MyApp extends StatefulWidget {
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    _auth() async {
  }
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Flutter Login Web',
      home: Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        body: MyAppView(),
      ), //MyAppView() **En temps normal//*/*GetStarted
      debugShowCheckedModeBanner: false,
    );
  }
}



class MyAppView extends StatefulWidget {
  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  var errors;
  var loading_login;
  @override
  void initState() {
    super.initState();
    errors = ' ';
    loading_login = false;
  }

  final _mainControllers = {
    //Declarations
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  final _regControllers = {
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'password_confirm': TextEditingController(),
  };

  void dispose() {
    _mainControllers['email']?.dispose();
    _mainControllers['password']?.dispose();
    _regControllers['name']?.dispose();
    _regControllers['phone']?.dispose();
    _regControllers['email']?.dispose();
    _regControllers['password']?.dispose();
    _regControllers['password_confirm']?.dispose();
  }

  var invoker = 'login';
  void _switchMenu(String caller) {
    setState(() {
      invoker = caller;
      errors = ' ';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Menu(
            invoker: invoker,
            pressFunction: _switchMenu,
          ).build(context),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          MediaQuery.of(context).size.width > 720
              ? Body(context)
              : MobileMainBody(),
        ],
      ),
    );
  }
  /*/**/* */

  /***/ /* */

  Widget Body(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'The African referential in Data Analysis',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "If you don't have an account",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "You can",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {
                      print(MediaQuery.of(context).size.width);
                      //On devrait ajouter un evenement de click pour ouvrir _*inscription*_
                      /*J'ajoute l'evenement en question*/
                      _switchMenu('register');
                    },
                    child: const Text(
                      "Register here!",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'images/illustration-2.png',
                width: 300,
              ),
            ],
          ),
        ),
        Image.asset(
          'images/illustration-1.png',
          width: 300,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: 320,
            child: _formRegistration(context),
          ),
        )
      ],
    );
  }

  Widget _formRegistration(BuildContext buildContext) {
    return Column(
      children: [
//==================EMAIl FIELD================================
        if (invoker == 'login')
          LoginForm(buildContext)
        else
          RegisterForm(buildContext),

//==================SUBMISSION BUTTON END=====================

        SizedBox(height: 40),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.blue[300],
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text("Or continue with"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              height: 50,
            ),
          ),
        ]),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _loginWithButton(image: 'images/google.png'),
            _loginWithButton(image: 'images/github.png', isActive: true),
            _loginWithButton(image: 'images/facebook.png'),
          ],
        ),
      ],
    );
  }

  Widget RegisterForm(BuildContext buildContext) {
    return Column(
      children: [
        Text(
          errors,
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(
          height: 30,
        ),
        CustomTextField(title: 'Nom', placeholder: 'Nom').textFormField(
          txtController: _regControllers['name'],
        ),
        SizedBox(height: 30),
        CustomTextField(title: 'Telephone', placeholder: 'Telephone')
            .textFormField(txtController: _regControllers['phone']),
        SizedBox(height: 30),
        CustomTextField(title: 'Email', placeholder: 'Email').textFormField(
          txtController: _regControllers['email'],
        ),
        SizedBox(height: 30),
        CustomTextField(title: 'Mot de passe', placeholder: 'Mot de passe')
            .textFormField(
          obscure: true,
          txtController: _regControllers['password'],
        ),
        SizedBox(height: 30),
        CustomTextField(
                title: 'Confirmer le mot de passe',
                placeholder: 'Confirmer le mot de passe')
            .textFormField(
          obscure: true,
          txtController: _regControllers['password_confirm'],
        ),
        SizedBox(height: 40),
        //====================SUBMISSION BUTTON ==========================
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign Up"))),
            onPressed: () {
              //Form Submission Gestionner
              var name = _regControllers['name']?.text;
              var phone = _regControllers['phone']?.text;
              var regEmail = _regControllers['email']?.text;
              var regPassword = _regControllers['password']?.text;
              var regPasswordConfirm =
                  _regControllers['password_confirm']?.text;
              var data = {
                'name': name,
                'phone': phone,
                'email': regEmail,
                'password': regPassword,
                'password_confirm': regPasswordConfirm
              };
              _register(data, context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),

//==================SUBMISSION BUTTON END=====================
      ],
    );
  }

  Widget LoginForm(BuildContext Context) {
    return Column(
      children: [
        Text(errors, style: TextStyle(color: Colors.red)),
        SizedBox(height: 30),
        CustomTextField(title: 'Email', placeholder: 'Email').textFormField(
          txtController: _mainControllers['email'],
        ),
        SizedBox(height: 30),
        CustomTextField(title: 'password', placeholder: 'password')
            .textFormField(
                txtController: _mainControllers['password'], obscure: true),
        TextButton(
            onPressed: () {
              print("password forgotten");
            },
            child: Text("Mot de passe oublié ?")),
        SizedBox(height: 40),

//====================SUBMISSION BUTTON ==========================
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: () async {
              var email = _mainControllers['email']?.text;
              var password = _mainControllers['password']?.text;

              setState(() {
                     loading_login = true;
              });

              var data = {"email": email, "password": password};
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('password', data['password']!);
              _login(data, Context);

            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child:  (loading_login)
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1.5,
                    ))
                :Container(height: 50, child: Center(child: Text("Sign In"))),
          ),
        ),
      ],
    );
  }


  void _login(data,  context) async {
    var res = await CallApi().AuthenticateUser(data);
    var body = json.decode(res.body);
    if (await body['status'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', body['token']);
      prefs.setString('name', body['user']['name']);
      prefs.setString('email', body['user']['email']);
      prefs.setString('phone', body['user']['phone']);
      Navigator.push( context, MaterialPageRoute(builder: (context) => UserHome()));
    } else {
      setState(() {

        errors = body['message'];
        loading_login = false;
      });
      print(body['message']);
    }
  }

  void _register(data, BuildContext context) async {
    try {
      var res = await CallApi().postData(data, 'register');
      var body = json.decode(res.body);
      print(body);
      if (await body['status'] == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserHome()));
      } else {
        setState(() {
          errors = body['message'];
        });
        print(body['message']);
      }
    } catch (e) {
      setState(() {
        errors = 'Oops !! please refresh and try again';
      });
    }
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    if (invoker == 'login') {
      print("Connexion");
    }
    if (invoker == "register") {
      print("Inscription");
    }

    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
      child: Center(
          child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 15,
                  )
                ],
              )
            : BoxDecoration(),
        child: Image.asset(
          '$image',
          width: 35,
        ),
      )),
    );
  }
}
