// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:data_sc_tester/CompleterProfil.dart';
import 'package:data_sc_tester/api/CallApi.dart';
import 'package:data_sc_tester/skills/TextField.dart';
import 'package:data_sc_tester/skills/ToastWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'skills/Navigation.dart';
import 'UserPage.dart';

//**
//  CORRESPOND EGALEMENT A LA PAGE DE CONNEXION
// */
void main() async {
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  print(token);
  runApp(MaterialApp(home: redirectAuth(token)));
}

redirectAuth(token) {
  if (token == null) {
    return MyApp();
  } else {
    _connectCurrentUser();
    return UserHome();
  }
}

void _connectCurrentUser() async {
  final prefs = await SharedPreferences.getInstance();
  var data = {
    "email": prefs.getString('email'),
    "password": prefs.getString('password')
  };

  var res = await CallApi().AuthenticateUser(data);
  var body = json.decode(res.body);
  if (await body['status'] == 200) {
    print('connecter');
  } else {
    print(body['message']);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Flutter Login Web',
      home: const Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        body: MyAppView(),
      ), //MyAppView() **En temps normal//*/*InscriptionPage
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppView extends StatefulWidget {
  const MyAppView({Key? key}) : super(key: key);

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  var errors;
  var loading_login, loading_register;
  @override
  void initState() {
    super.initState();
    errors = ' ';
    loading_login = false;
    loading_register = false;
  }

  final _mainControllers = {
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
    _mainControllers.forEach((key, value) {
      _mainControllers[key]?.dispose();
    });
    _regControllers.forEach((key, value) {
      _regControllers[key]?.dispose();
    });
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 16,
            right: MediaQuery.of(context).size.width / 16),
        children: [
          Menu(
            invoker: invoker,
            pressFunction: _switchMenu,
          ).build(context),
          Body(context)
        ],
      ),
    );
  }

  Widget Body(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 12),
          child: SizedBox(
            width: 300,
            child: _formRegistration(context),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width < 380
              ? 12 * MediaQuery.of(context).size.width / 16
              : 360,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'La réference Africaine en analyse des données ',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                invoker == "login"
                    ? "Si vous n'avez pas encore de compte"
                    : "Si Vous avez déja un compte",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Vous pouvez",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 15),
                  TextButton(
                    onPressed: () =>
                        _switchMenu(invoker == "login" ? 'register' : "login"),
                    child: Text(
                        invoker == "login"
                            ? "Vous Inscrire ici !"
                            : "Vous Connecter ici !",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Image.asset('images/illustration-2.png', width: 300),
            ],
          ),
        ),
        Image.asset('images/illustration-1.png', width: 300),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
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

  Map<int, bool> obscure = {
    //1:connextion; 2-inscription (pass), 3-inscription:(cnofirmaerpass)
    1: true, 2: true, 3: true
  };
  void pass_obscurer(int index) {
    print("object");
    setState(() {
      obscure[index] = obscure[index] == false ? true : false;
    });
  }

  Widget RegisterForm(BuildContext buildContext) {
    return Column(
      children: [
        Text(errors, style: TextStyle(color: Colors.red)),
        SizedBox(height: 30),
        CustomTextField(title: 'Nom', placeholder: 'Nom')
            .textFormField(txtController: _regControllers['name']),
        SizedBox(height: 30),
        CustomTextField(title: 'Téléphone', placeholder: 'Téléphone')
            .textFormField(txtController: _regControllers['phone']),
        SizedBox(height: 30),
        CustomTextField(title: 'Email', placeholder: 'Email')
            .textFormField(txtController: _regControllers['email']),
        SizedBox(height: 30),
        CustomTextField(title: 'Mot de passe', placeholder: 'Mot de passe')
            .textFormField(
                hider: pass_obscurer,
                index: 2,
                obcurer: obscure,
                txtController: _regControllers['password']),
        SizedBox(height: 30),
        CustomTextField(
                title: 'Confirmer le mot de passe',
                placeholder: 'Confirmer le mot de passe')
            .textFormField(
                hider: pass_obscurer,
                index: 3,
                obcurer: obscure,
                txtController: _regControllers['password_confirm']),
        SizedBox(height: 40),
        //====================SUBMISSION BUTTON ==========================
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: () {
              //Form Submission Gestionner
              var data = {
                'name': _regControllers['name']?.text,
                'phone': _regControllers['phone']?.text,
                'email': _regControllers['email']?.text,
                'password': _regControllers['password']?.text,
                'password_confirm': _regControllers['password_confirm']?.text
              };
              setState(() {
                loading_register = true;
              });
              _register(data, context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: SizedBox(
                height: 50,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.only(left: 36),
                    child: const Text("S'inscrire'"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 16,
                    width: 16,
                    child:
                        loading_register //Tu remplacera ici par le booléen de la fonction register !
                            ? SpinKitCircle(
                                size: 14,
                                color: Colors.white,
                              )
                            //  CircularProgressIndicator(
                            //     strokeWidth: 2,
                            //     color: Colors.white,
                            //   )
                            : Wrap(),
                  )
                ])),
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
        CustomTextField(title: 'Mot de Passe', placeholder: 'Mot de passe')
            .textFormField(
                txtController: _mainControllers['password'],
                hider: pass_obscurer,
                index: 1,
                obcurer: obscure),
        TextButton(
            onPressed: () {
              print("Mot de passe oublié : Il faut gerer ça !");
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
            child: SizedBox(
                height: 50,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.only(left: 52),
                    child: const Text("Se Connecter"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    height: 24,
                    width: 30,
                    child: loading_login
                        ? SpinKitDoubleBounce(
                            size: 20,
                            color: Colors.white,
                          )
                        : Wrap(),
                  )
                ])),
          ),
        ),
      ],
    );
  }

  void _login(data, context) async {
    makeToast(
        msg: "Veuillez patienter le temps que nous vous connectons",
        type: 'debug', context: context);
    var res = await CallApi().AuthenticateUser(data);
    var body = json.decode(res.body);
    if (await body['status'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('token', body['token']);
      prefs.setString('name', body['user']['name']);
      prefs.setString('email', body['user']['email']);
      prefs.setString('phone', body['user']['phone']);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserHome()));
    } else {
      makeToast(
          msg:
              "Echec de la connexion, verifier votre connexion internet et  vos identifiants puis reéssayer",
          type: "alert", context: context);
      setState(() {
        errors = body['message'];
        loading_login = false;
      });
      print(body['message']);
    }
  }

  void _register(data, BuildContext context) async {
    makeToast(
        msg: "Veuillez patienter le temps de l'inscription", type: 'debug', context: context);
    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);
    print(body['user']);

    if (await body['status'] == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', body['token']);
      prefs.setString('name', body['user']['name']);
      prefs.setString('email', body['user']['email']);
      prefs.setInt('phone', body['user']['phone']);
      prefs.setInt('id', body['user']['id']);
      // ignore: use_build_context_synchronously
      print('iciiii');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InscriptionPage()));
    } else {
      setState(() {
        errors = body['message'];
        loading_register = false;
      });
      makeToast(
          msg:
              "Echec de l'inscription, verifier votre connexion internet et  vos identifiants puis reéssayez ",
          type: "alert", context:  context);
      print(body['message']);
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
              // ignore: prefer_const_literals_to_create_immutables
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
                // ignore: prefer_const_literals_to_create_immutables
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
          image,
          width: 35,
        ),
      )),
    );
  }
}
