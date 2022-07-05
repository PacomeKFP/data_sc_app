import 'package:flutter/material.dart';

Widget UserProfile(String name, String image, BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage: AssetImage(image),
        radius: 20,
      ),
      // const SizedBox(width: 10),
      MediaQuery.of(context).size.width >720 ?
      Text(
        name,
        style: const TextStyle(fontFamily: 'Gabriela', fontSize: 16),
      ):Wrap(),
    ]),
  );
}

Widget CircleImage(String path, int _radius) {
  return CircleAvatar(
    backgroundColor: Color.fromARGB(199, 131, 131, 131),
    radius: _radius + 2.0,
    child: CircleAvatar(
      backgroundImage: AssetImage(path),
      radius: _radius + 0.0,
    ),
  );
}


