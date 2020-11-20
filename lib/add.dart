import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'camera.dart';

class NewScreen extends StatefulWidget {
  List persons;

  NewScreen(this.persons);

  @override
  State<StatefulWidget> createState() {
    return MyCustomForm();
  }
}

class MyCustomForm extends State<NewScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _navnController = TextEditingController();
  TextEditingController _alderController = TextEditingController();
  TextEditingController _jobController = TextEditingController();
  TextEditingController _retController = TextEditingController();

  String path;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(title: Text('New Screen')),
        body: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _navnController,
                    decoration: InputDecoration(
                      hintText: 'Navn',
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
                    child: Text('Camera', style: TextStyle(fontSize: 24.0)),
                    onPressed: () async {
                      WidgetsFlutterBinding.ensureInitialized();
                      final cameras = await availableCameras();
                      final firstCamera = cameras.first;

                      path = join(
                        // Store the picture in the temp directory.
                        // Find the temp directory using the `path_provider` plugin.
                        (await getApplicationDocumentsDirectory()).path,
                        '${DateTime.now()}.png',
                      );

                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => TakePictureScreen(
                                  camera: firstCamera, path: path)))
                          .then((value) => setState(() {}));
                    }),
                ElevatedButton(
                  child: Text(
                    'gem',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      widget.persons.add(Person(
                          'assets/images/logo.png',
                          path,
                          _navnController.text,
                          _alderController.text,
                          _jobController.text,
                          _retController.text));

                      print(jsonEncode(widget.persons));

                      final filename = join(
                          (await getApplicationDocumentsDirectory()).path,
                          'persons.json');
                      File file = File(filename);
                      file.writeAsString(jsonEncode(widget.persons)); // 2

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )));
  }
}
