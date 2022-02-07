import 'package:flutter/material.dart';

class Button {
  final String value;
  final Color backgroundColor;
  final Color foregroundColor;

  Button(this.value, this.backgroundColor, this.foregroundColor);
}

List<Button> buttons = [
  Button('C', Colors.grey, Colors.black),
  Button('⁺∕₋', Colors.grey, Colors.black),
  Button('%', Colors.grey, Colors.black),
  Button('÷', Colors.orange, Colors.white),
  Button('7', Colors.grey.shade800, Colors.white),
  Button('8', Colors.grey.shade800, Colors.white),
  Button('9', Colors.grey.shade800, Colors.white),
  Button('×', Colors.orange, Colors.white),
  Button('4', Colors.grey.shade800, Colors.white),
  Button('5', Colors.grey.shade800, Colors.white),
  Button('6', Colors.grey.shade800, Colors.white),
  Button('−', Colors.orange, Colors.white),
  Button('1', Colors.grey.shade800, Colors.white),
  Button('2', Colors.grey.shade800, Colors.white),
  Button('3', Colors.grey.shade800, Colors.white),
  Button('+', Colors.orange, Colors.white),
  Button('0', Colors.grey.shade800, Colors.white),
  Button('.', Colors.grey.shade800, Colors.white),
  Button('=', Colors.orange, Colors.white),
];
