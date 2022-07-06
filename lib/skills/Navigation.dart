import 'package:data_sc_tester/main.dart';
import 'package:flutter/material.dart';

var change = true;

class Menu {
  final String invoker;
  final void Function(String caller) pressFunction;

  Menu({required this.pressFunction, required this.invoker});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 30, left: MediaQuery.of(context).size.width / 32),
      child: Row(
        crossAxisAlignment: MediaQuery.of(context).size.width < 720
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MediaQuery.of(context).size.width < 720
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            children: [
              _menuItem(
                  title: 'Connexion',
                  isActive: invoker == "login" ? true : false,
                  name: 'login',
                  pressFunction: pressFunction),
              const SizedBox(width: 10),
              _menuItem(
                  title: 'Inscription',
                  name: 'register',
                  isActive: invoker == "register" ? true : false,
                  pressFunction: pressFunction),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
      {String title = 'Title Menu',
      required String name,
      isActive = false,
      required void Function(String caller) pressFunction}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(),
              ),
              onPressed: () {
                pressFunction(name);
              },
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.blue : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 6),
            isActive
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : Wrap()
          ],
        ),
      ),
    );
  }
}
