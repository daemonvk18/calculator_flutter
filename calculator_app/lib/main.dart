import 'package:calculator_app/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = '';
  var userAnswer = '';

  List<String> gridcontainers = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "X",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.0,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          userQuestion,
                          style: TextStyle(fontSize: 22.0),
                        )),
                    Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          userAnswer,
                          style: TextStyle(fontSize: 22.0),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                child: GridView.builder(
                    itemCount: gridcontainers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Buttons(
                            ButtonTap: () {
                              setState(() {
                                userQuestion = '';
                              });
                            },
                            color: Colors.green,
                            textcolor: Colors.white,
                            buttonText: gridcontainers[index]);
                      } else if (index == 1) {
                        return Buttons(
                            ButtonTap: () {
                              setState(() {
                                try {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          content: Text(
                                            "there is nothing to delete",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                color: Colors.black),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('OK'))
                                          ],
                                        );
                                      });
                                }
                              });
                            },
                            color: Colors.red,
                            textcolor: Colors.white,
                            buttonText: gridcontainers[index]);
                      }

                      //dealing with equal to button.
                      else if (index == gridcontainers.length - 1) {
                        return Buttons(
                            //when the equal to button is tapped we should be printing the answer
                            ButtonTap: () {
                              setState(() {
                                equalmethod();
                              });
                            },
                            color: Colors.deepPurple,
                            textcolor: Colors.white,
                            buttonText: gridcontainers[index]);
                      } else {
                        return Buttons(
                            ButtonTap: () {
                              setState(() {
                                userQuestion += gridcontainers[index];
                              });
                            },
                            color: Operators(gridcontainers[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            textcolor: Operators(gridcontainers[index])
                                ? Colors.white
                                : Colors.deepPurple,
                            buttonText: gridcontainers[index]);
                      }
                    })),
          ),
        ],
      ),
    );
  }

  bool Operators(String x) {
    if (x == "%" || x == "/" || x == "X" || x == "-" || x == "+" || x == "=") {
      return true;
    } else {
      return false;
    }
  }

  void equalmethod() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("X", "*");

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
