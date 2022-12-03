import 'package:flutter/material.dart';

Widget commonButton(
    {required String text, required Function onPressed, double? minWidth}) {
  return MaterialButton(
    onPressed: () => onPressed(),
    color: Colors.blue[900],
    height: 45,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    minWidth: minWidth,
    child: Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
    ),
  );
}
