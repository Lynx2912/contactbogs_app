import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'models/profilemodel.dart';

class EditScreen extends StatefulWidget {
  final Person person;
  final List persons;
  EditScreen(this.person, this.persons);
  State<StatefulWidget> createState() {
    return MyCustomForm2();
  }
}

class MyCustomForm2 extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _navnController = TextEditingController();
  TextEditingController _alderController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _retController = TextEditingController();

  MyCustomForm2();

  @override
  void initState() {
    _navnController.text = widget.person.navn;
    _alderController.text = widget.person.alder;
    _jobController.text = widget.person.job;
    _retController.text = widget.person.ynglingsret;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('New Screen')),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _navnController,
                  decoration: InputDecoration(
                    hintText: 'navn',
                    counterText: '0 characters',
                    border: const OutlineInputBorder(),
                  )),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  // The validator receives the text that the user has entered.
                  controller: _alderController,
                  decoration: InputDecoration(
                    hintText: 'Alder',
                    counterText: '0 characters',
                    border: const OutlineInputBorder(),
                  )),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _jobController,
                  decoration: InputDecoration(
                    hintText: 'Job',
                    counterText: '0 characters',
                    border: const OutlineInputBorder(),
                  )),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _retController,
                  decoration: InputDecoration(
                    hintText: 'Ynglingsret',
                    counterText: '0 characters',
                    border: const OutlineInputBorder(),
                  ) // Add TextFormFields and ElevatedButton here.
                  ),
              ElevatedButton(
                  child: Text(
                    'gem',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      widget.person.navn = _navnController.text;
                      widget.person.alder = _alderController.text;
                      widget.person.job = _jobController.text;
                      widget.person.ynglingsret = _retController.text;
                      print(jsonEncode(widget.person));
                      final filename = join(
                          (await getApplicationDocumentsDirectory()).path,
                          'persons.json');
                      File file = File(filename);
                      await file.writeAsString(jsonEncode(widget.persons));
                      Navigator.pop(context);
                    }
                  })
            ])));
  }
}
