import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = TextField(
  autofocus: true,
  decoration: InputDecoration(
    border:OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0),),
    ),
    filled: true,
    fillColor: Color(0x30AC7339),
    icon: Icon(
      Icons.travel_explore,
      color: Color(0xFFc68c53),
    ),
    hintText: 'Enter City Name',
  ),
);