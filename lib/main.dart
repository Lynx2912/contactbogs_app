import 'package:HolionApp/models/profilemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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

  void fillList() {
    Person niels = Person(
        'assets/images/logo.png',
        'assets/images/Anmærkning 2020-11-17 115919.png',
        'Niels',
        '40',
        'Chef',
        'Parboiledris med en smørklat');

    Person mads = Person(
        'assets/images/logo.png',
        'assets/images/20201117_083915.jpg',
        'Mads',
        '27',
        'Programmør',
        'Rødt kød');

    Person lukas = Person(
        'assets/images/logo.png',
        'assets/images/20201117_083919.jpg',
        'Lukas',
        '15',
        'Practikant',
        'Australsk burger');
    Person mathias = Person(
        'assets/images/logo.png',
        'assets/images/20201117_083924.jpg',
        'Mathias',
        '23',
        'Programmør',
        'Alt med sovs');
    personList.add(niels);
    personList.add(mads);
    personList.add(lukas);
    personList.add(mathias);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Text'),
      ),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return display(personList[index]);
        },
        itemCount: personList.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(
            MaterialPageRoute(builder: (context) => NewScreen(this.personList)))
        .then((value) => setState(() {}));
  }

  Widget display(Person person) {
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
        new Container(
            width: 450.0,
            height: 450.0,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill, image: new AssetImage(person.billed)))),
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
        RaisedButton(
          child: Text(
            'Navigate to a new screen >>',
            style: TextStyle(fontSize: 24.0),
          ),
          onPressed: () {
            _navigateToNextScreen(context);
          },
        )
      ],
    ));
  }
}

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
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      widget.persons.add(Person(
                          'assets/images/logo.png',
                          'assets/images/Anmærkning 2020-11-17 115919.png',
                          _navnController.text,
                          _alderController.text,
                          _jobController.text,
                          _retController.text));

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )));
  }
}
