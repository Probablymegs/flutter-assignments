// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:assignment2/main.dart';
import 'package:flutter/material.dart';
import 'package:assignment2/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Enable buttons'),
              Switch(
                value: enabled,
                onChanged: (value) => setState(() {
                  enabled = value;
                }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked++;
                    });
                  },
                  child: Text(
                      timesClicked == 0 ? "Click me" : "Clicked $timesClicked"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked = 0;
                    });
                  },
                  child: Text("Reset"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: textEditingController,
                    validator: (input) {
                      return input!.length > 20
                          ? 'Max 20 characters'
                          : input.isEmpty
                              ? 'Min 1 characters'
                              : null;
                    },
                    maxLength: 20,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.hourglass_top),
                      suffixIcon: Icon(Icons.check_circle),
                      labelText: 'first name',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      helperText: 'min 1, max 20',
                    ),
                    onSaved: (input) {
                      firstName = input;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              textEditingController.clear();
                              scaffoldMessengerKey.currentState?.showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 5),
                                  behavior: SnackBarBehavior.floating,
                                  content: Row(children: [
                                    const Icon(Icons.favorite,
                                        color: Colors.white),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Hey $firstName',
                                        style: TextStyle(fontSize: 14.0)),
                                    TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.transparent)),
                                      onPressed: () =>
                                          print("you clicked the snackbar!"),
                                      child: Text(
                                        "Click me",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                      ),
                                    )
                                  ]),
                                ),
                              );
                            }
                          },
                          child: Text('Submit')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
