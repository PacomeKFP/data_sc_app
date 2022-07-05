import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabMenu {
  final Map tab; //{key, name}
  final List<Map> Items;
  final bool state;

  TabMenu({required this.tab, required this.Items, this.state = false});

  Widget getTab(
      {bool isActive = false, required void Function(String key, int degree) pressEvent}) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: IconButton(
            icon: Icon(isActive
                ? Icons.arrow_downward_rounded
                : Icons.arrow_forward_ios_rounded),
            onPressed: () {
              //derouler, enrouler
              pressEvent(tab['key'], 0);
            },
          ),
          title: Text(tab['name']),
          subtitle: Column(
            children: [
              if (isActive == true)
                _children(pressEvent: pressEvent)
              else
                Divider(height: 2, thickness: 1, indent: 5),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _children({required void Function(String key, int degree) pressEvent}) {
    return Column(
      children: [
        for (var item in Items)
          TextButton(
            child: Text(item['name']),
            onPressed: () => pressEvent(item['key'], 1),
          ),
      ],
    );
  }
}
