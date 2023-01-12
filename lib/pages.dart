import 'package:flutter/material.dart';

class Pages {
  static double fontSizeBig = 20;
  static double fontSizeSmall = 20;

  static MaterialApp loadingApp(String title) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
            ),
          )),
    );
  }

  static AppBar topBar(String title) {
    return AppBar(
      title: Text(title),
      bottom: TabBar(tabs: [
        Tab(
          text: "Standings",
        ),
        Tab(
          text: "Drivers",
        ),
        Tab(
          text: "Races",
        ),
        Tab(
          text: "Teams",
        ),
        Tab(
          text: "Circuits",
        ),
      ]),
    );
  }

  static SingleChildScrollView standingsPage(List _driverList,
      List _constructorList, List _winsList, List _pointsList) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.3),
            2: FlexColumnWidth(0.4),
            3: FlexColumnWidth(0.2),
            4: FlexColumnWidth(0.2),
            5: FlexColumnWidth(0.2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: List<TableRow>.generate(_driverList.length, (index) {
            final driver = _driverList[index];
            final constructor = _constructorList[index];
            final win = _winsList[index];
            final point =
                _pointsList.cast<String>().map(double.parse).toList()[index];
            final pointFirst =
                _pointsList.cast<String>().map(double.parse).toList()[1];
            if (index == 0) {
              return TableRow(
                decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 5, bottom: 5),
                      child: Text(
                        "POS",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "Driver",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "CAR",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "WINS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "POINTS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "GAP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                ],
              );
            }

            return TableRow(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                    child: Text(
                      index.toStringAsFixed(0),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      driver.GetNumber() +
                          " " +
                          driver.givenName +
                          " " +
                          driver.familyName,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      constructor.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      win,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      point.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      (point - pointFirst).toStringAsFixed(0),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }

  static SingleChildScrollView driversPage(
      List _driverList, List _constructorList) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.4),
            1: FlexColumnWidth(0.3),
            2: FlexColumnWidth(0.2),
            3: FlexColumnWidth(0.3),
          },
          border: TableBorder.all(color: Colors.grey),
          children: List<TableRow>.generate(_driverList.length, (index) {
            final driver = _driverList[index];
            final constructor = _constructorList[index];
            final win = driver.totalWin;
            final point = driver.totalPoint;
            if (index == 0) {
              return TableRow(
                decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "DRIVER",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "TEAM",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "WINS ALL TIME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "POINTS ALL TIME",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                ],
              );
            }

            return TableRow(
              children: [
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      driver.GetNumber() +
                          " " +
                          driver.givenName +
                          " " +
                          driver.familyName,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      constructor.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      win.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      point.toStringAsFixed(0),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }

  static SingleChildScrollView racesPage(List _raceList) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.35),
            1: FlexColumnWidth(0.3),
            2: FlexColumnWidth(0.5),
            3: FlexColumnWidth(0.4),
            4: FlexColumnWidth(0.4),
          },
          border: TableBorder.all(color: Colors.grey),
          children: List<TableRow>.generate(_raceList.length, (index) {
            final race = _raceList[index];
            if (index == 0) {
              return TableRow(
                decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 5, bottom: 5),
                      child: Text(
                        "DATE",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "RACE",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "CIRCUIT",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "WINNER",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "POLE POSITION",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                ],
              );
            }

            return TableRow(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                    child: Text(
                      race.date,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      race.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      race.circuit,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      race.winner,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      race.pole,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }

  static SingleChildScrollView circuitsPage(List _circuitList) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.4),
            1: FlexColumnWidth(0.2),
            2: FlexColumnWidth(0.2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: List<TableRow>.generate(_circuitList.length, (index) {
            final circuit = _circuitList[index];
            if (index == 0) {
              return TableRow(
                decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 5, bottom: 5),
                      child: Text(
                        "NAME",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "LOCALITY",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "COUNTRY",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                ],
              );
            }

            return TableRow(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                    child: Text(
                      circuit.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      circuit.locality,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      circuit.country,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }

  static SingleChildScrollView teamsPage(List _constructorStandings) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(0.4),
            2: FlexColumnWidth(0.2),
            3: FlexColumnWidth(0.2),
          },
          border: TableBorder.all(color: Colors.grey),
          children:
              List<TableRow>.generate(_constructorStandings.length, (index) {
            final constructorStanding = _constructorStandings[index];
            if (index == 0) {
              return TableRow(
                decoration: BoxDecoration(color: Colors.grey[400]),
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 5, bottom: 5),
                      child: Text(
                        "NAME",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "NATIONALITY",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "WINS",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                  Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        "POINTS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: fontSizeBig),
                      )),
                ],
              );
            }

            return TableRow(
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 5),
                    child: Text(
                      constructorStanding.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      constructorStanding.nationality,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      constructorStanding.wins,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
                Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      constructorStanding.points,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: fontSizeSmall),
                    )),
              ],
            );
          }),
        ),
      ),
    );
  }

  static Stack yearPicker(DateTime _selectedDate, Function(DateTime) yearInput,
      double contextHeight) {
    return Stack(
      children: [
        Container(
          color: Color.fromARGB(255, 2, 170, 248),
          height: contextHeight * 0.1,
          child: YearPicker(
            firstDate: DateTime.utc(1950),
            initialDate: DateTime.utc(2022),
            lastDate: DateTime.utc(2022),
            selectedDate: _selectedDate,
            onChanged: yearInput,
          ),
        ),
      ],
    );
  }
}
