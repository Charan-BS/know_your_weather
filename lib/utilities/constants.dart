import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  color: Colors.white,
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 35.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(fontSize: 90.0);

const kTextFieldDecoration = InputDecoration(
  hintText: 'ENTER A CITY NAME',
  hintStyle: TextStyle(color: Colors.white, fontSize: 17),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
);
