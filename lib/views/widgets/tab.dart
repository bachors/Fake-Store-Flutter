import 'package:flutter/material.dart';

Widget buildTab(String label, bool selected) {
  return Tab(
    child: Container(
      height: 40,
      padding: const EdgeInsets.only(right: 10, left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? const Color(0xff181c1f) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xff181c1f)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : const Color(0xff181c1f),
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}