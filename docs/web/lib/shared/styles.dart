import 'package:flutter/material.dart';

const cAppTitle = "Procure2Pay.ai";

enum cMessageType { error, success }

const cNavColor = Colors.white;

const cTitleText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cNavText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cBodyText = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal);

const cNavRightText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);
const cErrorText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.red,
);
const cWarnText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.yellow,
);
const cSuccessText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Colors.green,
);

const cHeaderText = TextStyle(
    color: Colors.black54,
    fontSize: 16.0,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.normal);

const cHeaderWhiteText = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

const cHeaderDarkText = TextStyle(
    color: Colors.black26,
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal);

var cThemeData = ThemeData(
  primaryColor: Colors.blue,
  //primarySwatch: Colors.white,
  buttonColor: Colors.blue,
  backgroundColor: Colors.white,
  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
);
