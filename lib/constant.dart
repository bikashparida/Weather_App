import 'package:flutter/material.dart';

const kTemperatureTextStyle = TextStyle(fontSize: 70.0, color: Colors.white);
const kIconTextStyle = TextStyle(fontSize: 50.0, color: Colors.white);
const kMessageTextStyle = TextStyle(fontSize: 50.0);
const kButtonTextStyle =
    TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.white);
const kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
