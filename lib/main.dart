import 'package:flutter/material.dart';
import 'package:flutter_calculator/button_values.dart';

void main() => runApp(MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const Calculator(),
    ));

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> string = [];
  Buttons? operator;
  double? result;

  String functions() {
    String data = '';

    for (var element in string) {
      data += '$element ';
    }

    return data;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SizedBox(
            width: 350,
            child: Column(
              children: [
                // Display
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          functions(),
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          string.isEmpty ? '' : string.last,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons
                Wrap(children: Buttons.values.map((e) => button(data: e)).toList()),
              ],
            ),
          ),
        ),
      );

  Widget button({required Buttons data}) {
    if (string.length == 3) {
      calculate(double.parse(string.first), double.parse(string.last));
    }

    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth * data.width,
        color: data.color,
        child: AspectRatio(
          aspectRatio: data.aspectRatio,
          child: ElevatedButton(
            onPressed: () => onPressed(data),
            style: ElevatedButton.styleFrom(
              backgroundColor: data.color,
              foregroundColor: data.textColor,
              fixedSize: const Size(double.maxFinite, double.maxFinite),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: Text(data.text),
          ),
        ),
      ),
    );
  }

  void calculate(double x, double y) => setState(() {
        if (operator == Buttons.divide) {
          result = (x / y);
        } else if (operator == Buttons.multiply) {
          result = (x * y);
        } else if (operator == Buttons.subtract) {
          result = (x - y);
        } else if (operator == Buttons.add) {
          result = (x + y);
        }
      });

  void onPressed(Buttons data) => setState(() {
        // clear
        if (data == Buttons.clr) {
          operator = null;
          string.clear();
        }

        // priority
        else if (data == Buttons.priority) {
          if (string.last.contains('(') && string.last.contains(')')) {
            string.last = string.last.replaceAll('(', '');
            string.last = string.last.replaceAll(')', '');
          } else if (string.last.contains('(')) {
            string.last = '${string.last})';
          } else if (string.last.contains(')')) {
            string.last = '(${string.last}';
          } else {
            string.last = '(${string.last})';
          }
        }

        // notation
        else if (data == Buttons.notation) {
          string.last = (double.parse(string.last) * (-1)).toString();
        }

        // dot
        else if (data == Buttons.dot) {
          if (!string.last.contains('.')) {
            string.last = '${string.last}.';
          }
        }

        // operatorFunction
        else if (data.isOperator) {
          if (string.last == '/' || string.last == '*' || string.last == '-' || string.last == '+') {
            string.last = data.text;
          } else {
            string.add(data.text);
          }
          operator = data;

          for (var element in string) {
            calculate(result ?? 0, double.parse(element));
          }
        }

        // number
        else if (data.isNumber) {
          if (string.isEmpty) {
            string.add(data.text);
          } else {
            if (string.last == '/' || string.last == '*' || string.last == '-' || string.last == '+') {
              string.add(data.text);
            } else {
              string.last += data.text;
            }
          }
        }

        // calculate
        else if (data == Buttons.calculate) {
          for (var i = 0; i < string.length; i++) {
            if (i % 2 == 0) {
              calculate(result ?? 0, double.parse(string[i]));
              string.clear();

              string.add(result.toString());
            }
          }
        }
      });
}
