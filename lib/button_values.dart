import 'package:flutter/material.dart';

enum Buttons {
  clr,
  priority,
  notation,
  divide,
  n7,
  n8,
  n9,
  multiply,
  n4,
  n5,
  n6,
  subtract,
  n1,
  n2,
  n3,
  add,
  n0,
  dot,
  calculate,
}

extension Data on Buttons {
  double get width => this == Buttons.n0 ? 0.5 : 0.25;

  double get aspectRatio => this == Buttons.n0 ? 2 : 1;

  bool get isNumber =>
      this == Buttons.dot ||
      this == Buttons.n0 ||
      this == Buttons.n1 ||
      this == Buttons.n2 ||
      this == Buttons.n3 ||
      this == Buttons.n4 ||
      this == Buttons.n5 ||
      this == Buttons.n6 ||
      this == Buttons.n7 ||
      this == Buttons.n8 ||
      this == Buttons.n9;

  bool get isOperator => this == Buttons.divide || this == Buttons.multiply || this == Buttons.add || this == Buttons.subtract;

  Color get color {
    switch (this) {
      case Buttons.clr:
      case Buttons.priority:
      case Buttons.notation:
      case Buttons.dot:
        return Colors.grey;
      case Buttons.divide:
      case Buttons.multiply:
      case Buttons.subtract:
      case Buttons.add:
      case Buttons.calculate:
        return Colors.green.withOpacity(0.25);
      default:
        return Colors.blueGrey;
    }
  }

  Color get textColor {
    switch (this) {
      case Buttons.clr:
      case Buttons.priority:
      case Buttons.notation:
      case Buttons.dot:
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  String get text {
    switch (this) {
      case Buttons.clr:
        return 'C';
      case Buttons.priority:
        return '( )';
      case Buttons.notation:
        return '+/-';
      case Buttons.divide:
        return '÷';
      case Buttons.multiply:
        return '*';
      case Buttons.add:
        return '+';
      case Buttons.subtract:
        return '-';
      case Buttons.calculate:
        return '=';
      case Buttons.dot:
        return '.';
      case Buttons.n0:
        return '0';
      case Buttons.n1:
        return '1';
      case Buttons.n2:
        return '2';
      case Buttons.n3:
        return '3';
      case Buttons.n4:
        return '4';
      case Buttons.n5:
        return '5';
      case Buttons.n6:
        return '6';
      case Buttons.n7:
        return '7';
      case Buttons.n8:
        return '8';
      case Buttons.n9:
        return '9';
    }
  }
}
