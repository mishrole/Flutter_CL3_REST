import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'list': Icons.list,
  'add': Icons.add,
};

Icon getIcon(String iconName) {
  return Icon(_icons[iconName], color: Colors.red,);
}