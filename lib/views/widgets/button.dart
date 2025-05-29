import 'package:flutter/material.dart';

Widget iconButton(BuildContext context,
    {required IconData icon,
      required VoidCallback onPressed,
      required Color color}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(10),
    ),
    child: IconButton(
      icon: Icon(icon, color: color),
      onPressed: onPressed,
    ),
  );
}