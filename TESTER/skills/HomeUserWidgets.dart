import 'package:flutter/material.dart';

Widget UserProfile(String name, String image, double width) {
  return Container(
    child: Row(children: [
      CircleAvatar(
        backgroundColor: Colors.black,
        backgroundImage: AssetImage(image),
        radius: 20,
      ),
      const SizedBox(width: 10),
      width > 720
          ? Text(
              name,
              style: const TextStyle(fontFamily: 'Gabriela', fontSize: 16),
            )
          : Wrap()
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
