import "utils.dart";
import "driver.dart";
import "constructor.dart";
import "race.dart";
import "pages.dart";
import "constructorStanding.dart";
import 'circuit.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:xml/xml.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Super Cool F1 Site'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String year = "2022";
  String url = "https://ergast.com/api/f1/2022/DriverStandings";

  var _driverList = [];
  var _raceList = [];
  var _constructorList = [];
  var _pointsList = [];
  var _winsList = [];
  var _circuitsList = [];
  var _constructorStandings = [];

  var _isLoaded = false;
  var _selectedDate = DateTime(2022);

  void fetchPosts() async {
    try {
      var response = await get(Uri.parse(url));
      var parsed = XmlDocument.parse(response.body);

      final driverList = parsed
          .findAllElements('Driver')
          .map((xmlElement) => Driver.fromXmlElement(xmlElement))
          .toList();

      final constructorList = parsed
          .findAllElements('Constructor')
          .map((xmlElement) => Constructor.fromXmlElement(xmlElement))
          .toList();

      var iter = parsed.findAllElements('Constructor');
      int i = 0;
      for (var xmlElement in iter) {
        for (var constructor in constructorList) {
          if (constructor.name ==
              Utils.firstOrNull(xmlElement.findElements('name'))) {
            constructor.drivers.add(driverList[i].familyName);
          }
        }
        i++;
      }
      driverList.insert(
          0, Driver(-1, "Name", "Number", "Date", "Nat", "", 0, 0));

      final points = parsed
          .findAllElements('DriverStanding')
          .map((xmlElement) => xmlElement.getAttribute('points'))
          .toList();

      final wins = parsed
          .findAllElements('DriverStanding')
          .map((xmlElement) => xmlElement.getAttribute('wins'))
          .toList();

      String raceUrl = "https://ergast.com/api/f1/$year/results/1";
      response = await get(Uri.parse(raceUrl));
      parsed = XmlDocument.parse(response.body);
      final races = parsed
          .findAllElements('Race')
          .map((xmlElement) => Race.fromXmlElement(xmlElement))
          .toList();

      raceUrl = "https://ergast.com/api/f1/$year/qualifying/1";
      response = await get(Uri.parse(raceUrl));
      parsed = XmlDocument.parse(response.body);
      var itar = parsed.findAllElements('Race');
      i = 0;
      for (var xmlElement in itar) {
        races[i++].pole = Utils.firstOrNull(xmlElement
            .findElements('QualifyingList')
            .first
            .findElements('QualifyingResult')
            .first
            .findElements('Driver')
            .first
            .findElements('FamilyName'));
      }

      raceUrl = "http://ergast.com/api/f1/circuits";
      response = await get(Uri.parse(raceUrl));
      parsed = XmlDocument.parse(response.body);

      final circuitList = parsed
          .findAllElements('Circuit')
          .map((xmlElement) => Circuit.fromXmlElement(xmlElement))
          .toList();

      raceUrl = "https://ergast.com/api/f1/$year/constructorStandings";
      response = await get(Uri.parse(raceUrl));
      parsed = XmlDocument.parse(response.body);

      final constructorStandings = parsed
          .findAllElements('ConstructorStanding')
          .map((xmlElement) => ConstructorStanding.fromXmlElement(xmlElement))
          .toList();

      await Future(
        () => {
          driverList.forEach((element) async {
            String driverId = element.driverId;
            String url =
                "http://ergast.com/api/f1/drivers/$driverId/driverStandings";

            var response = await get(Uri.parse(url));
            var parsed = XmlDocument.parse(response.body);
            var itar = parsed.findAllElements('DriverStanding');
            for (var xmlElement in itar) {
              element.totalWin +=
                  int.parse(Utils.emptyIfNull(xmlElement.getAttribute('wins')));
              element.totalPoint += int.parse(
                  Utils.emptyIfNull(xmlElement.getAttribute('points')));
            }
            setState(() {
              _driverList = driverList;
            });
          })
        },
      );

      await Future(() => setState(() {
            _driverList = driverList;

            _constructorList = constructorList;
            _constructorList.insert(0, Constructor("Name", "Name", []));

            _pointsList = points;
            _pointsList.insert(0, "0");

            _winsList = wins;
            _winsList.insert(0, "0");

            _raceList = races;
            _raceList.insert(0, Race("0", "0", "0", "0", "0"));

            _circuitsList = circuitList;
            _circuitsList.insert(0, Circuit("name", "loc", "count"));

            _constructorStandings = constructorStandings;
            _constructorStandings.insert(
                0, ConstructorStanding("-1s", "-1s", "name", "nat"));

            _isLoaded = true;
          }));
    } catch (err) {}
  }

  void yearInput(DateTime input) {
    setState(() {
      _isLoaded = false;
      _selectedDate = input;
    });

    year = input.year.toString();
    url = "https://ergast.com/api/f1/$year/DriverStandings";

    fetchPosts();
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    Pages.fontSizeBig = MediaQuery.of(context).size.width * 0.02;
    Pages.fontSizeSmall = MediaQuery.of(context).size.width * 0.025;
    return _isLoaded
        // If loaded
        ? MaterialApp(
            theme: ThemeData.from(
                colorScheme: ColorScheme.fromSwatch(
                    primarySwatch: Colors.blue,
                    cardColor: Colors.white,
                    accentColor: Colors.white,
                    primaryColorDark: Colors.white,
                    backgroundColor: Colors.white,
                    errorColor: Colors.white)),
            home: DefaultTabController(
                length: 5,
                child: Scaffold(
                    appBar: Pages.topBar(widget.title),
                    body: TabBarView(children: [
                      Pages.standingsPage(_driverList, _constructorList,
                          _winsList, _pointsList),
                      Pages.driversPage(_driverList, _constructorList),
                      Pages.racesPage(_raceList),
                      Pages.teamsPage(_constructorStandings),
                      Pages.circuitsPage(_circuitsList)
                    ]),
                    bottomNavigationBar: Pages.yearPicker(_selectedDate,
                        yearInput, MediaQuery.of(context).size.height))))
        // Still loading
        : Pages.loadingApp(widget.title);
  }
}
