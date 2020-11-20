import 'dart:convert';
import 'dart:io';

import 'package:HolionApp/edit.dart';
import 'package:HolionApp/models/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'add.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List personList = List();

  _MyHomePageState() {
    fillList();
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3

    return filePath;
  }

  void fillList() async {
    final filename =
        join((await getApplicationDocumentsDirectory()).path, 'persons.json');
    try {
      File file = File(filename);
      var fileContent = await file.readAsString();
      var personMap = jsonDecode(fileContent);
      personList =
          List.from(personMap).map((model) => Person.fromJson(model)).toList();
      setState(() {});
    } catch (ex) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Text'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          '+',
          style: TextStyle(fontSize: 36.0),
        ),
        onPressed: () {
          _navigateToNextScreen(context);
        },
      ),
      body: Container(
        child: Stack(
          children: [
            if (personList.length > 0)
              new Swiper(
                key: UniqueKey(),
                itemBuilder: (BuildContext context, int index) {
                  return display(context, personList[index], personList);
                },
                itemCount: personList.length,
                pagination: new SwiperPagination(),
                control: new SwiperControl(),
              ),
            if (personList.length == 0)
              Center(
                  child: Text(
                'vær sød at tilføge flere personer',
                style: TextStyle(fontSize: 24.0),
              ))
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(
            MaterialPageRoute(builder: (context) => NewScreen(this.personList)))
        .then((value) => setState(() {}));
  }

  void _navigateToNewScreen(BuildContext context, Person person, List persons) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => EditScreen(person, persons)))
        .then((value) => setState(() {}));
  }

  Widget display(BuildContext context, Person person, List persons) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Image(
            width: 150,
            height: 50,
            fit: BoxFit.fill,
            image: AssetImage(person.firma),
          ),
        ),
        RaisedButton(
          child: Text('Fjern Person', style: TextStyle(fontSize: 24.0)),
          onPressed: () async {
            personList.remove(person);
            var newlist = jsonEncode(personList);
            final filename = join(
                (await getApplicationDocumentsDirectory()).path,
                'persons.json');
            File file = File(filename);

            file.delete();
            file.writeAsString(newlist);

            setState(() {});
          },
        ),
        if (!person.billed.contains('assets'))
          CircleAvatar(
            backgroundImage: new FileImage(File(person.billed)),
            radius: 230.0,
          ),
        if (person.billed.contains('assets'))
          CircleAvatar(
            backgroundImage: AssetImage(person.billed),
            radius: 230.0,
          ),
        Row(children: [
          Text('Navn: ', style: TextStyle(fontSize: 25)),
          Text(person.navn, style: TextStyle(fontSize: 25)),
        ]),
        Row(
          children: [
            Text('Alder: ', style: TextStyle(fontSize: 25)),
            Text(person.alder, style: TextStyle(fontSize: 25)),
          ],
        ),
        Row(
          children: [
            Text('Stilling: ', style: TextStyle(fontSize: 25)),
            Text(person.job, style: TextStyle(fontSize: 25)),
          ],
        ),
        Row(
          children: [
            Text('Ynglingsret: ', style: TextStyle(fontSize: 25)),
            Align(
                child: Text(
                  person.ynglingsret,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.topRight),
          ],
        ),
        FlatButton(
            child: Text(
              'Rediger person',
              style: TextStyle(fontSize: 20.0),
            ),
            onPressed: () {
              _navigateToNewScreen(context, person, persons);
            })
      ],
    ));
  }
}
