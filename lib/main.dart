import 'style.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _Calculator(),
    ); // MaterialApp
  }
}

class _Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<_Calculator> {
  var pressedValue = '';
  var totalAnswer = '';

// Array of button
  final List<String> buttons = [
    'C',
    'DEL',
    '',
    '',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        backgroundColor: Colors.black12,
      ), //AppBar
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        pressedValue,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        totalAnswer,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return buttonStyle(
                        buttontapped: () {
                          setState(() {
                            pressedValue = '';
                            totalAnswer = '0';
                          });
                        },

                        buttonText: buttons[index],
                        color: Colors.black12,
                        textColor: Colors.orangeAccent,
                      );
                    }

                    // +/- button
                    else if (index == 3) {
                      return buttonStyle(
                        buttonText: buttons[index],
                        color: Colors.black12,
                        textColor: Colors.orangeAccent,

                      );
                    }
                    // % Button
                    else if (index == 2) {
                      return buttonStyle(
                        buttontapped: () {
                          setState(() {
                            pressedValue += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black12,
                        textColor: Colors.orangeAccent,
                      );
                    }
                    // Delete Button
                    else if (index == 1) {
                      return buttonStyle(
                        buttontapped: () {
                          setState(() {
                            pressedValue =
                                pressedValue.substring(0, pressedValue.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black12,
                        textColor: Colors.orangeAccent,
                      );
                    }
                    // Equal_to Button
                    else if (index == 18) {
                      return buttonStyle(
                        buttontapped: () {
                          setState(() {
                            showResult();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black12,
                        textColor: Colors.orangeAccent,
                      );
                    }

                    else {
                      return buttonStyle(
                        buttontapped: () {
                          setState(() {
                            pressedValue += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: operator(buttons[index])
                            ? Colors.black12
                            : Colors.orangeAccent,
                        textColor: operator(buttons[index])
                            ? Colors.orangeAccent
                            : Colors.black,
                      );
                    }
                  }), // GridView.builder
            ),
          ),
        ],
      ),
    );
  }

  bool operator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

// function to calculate the input operation
  void showResult() {
    String finalpressedValue = pressedValue;
    finalpressedValue = pressedValue.replaceAll('x', '*');

    Parser parsed = Parser();
    Expression exp = parsed.parse(finalpressedValue);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    totalAnswer = eval.toString();
  }
}
