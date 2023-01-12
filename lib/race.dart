import "utils.dart";
import 'package:xml/xml.dart';

class Race {
  final String date;
  final String name;
  final String circuit;
  final String winner;
  String pole;

  Race(
    this.date,
    this.name,
    this.circuit,
    this.winner,
    this.pole,
  );

  factory Race.fromXmlElement(XmlElement xmlElement) => Race(
        Utils.firstOrNull(xmlElement.findElements('Date')),
        Utils.firstOrNull(xmlElement.findElements('RaceName')),
        Utils.firstOrNull(Utils.findAndfirst(xmlElement, "Circuit")
            .findElements("CircuitName")),
        Utils.firstOrNull(Utils.findAndfirst(
                Utils.findAndfirst(
                    Utils.findAndfirst(xmlElement, "ResultsList"), "Result"),
                "Driver")
            .findElements('FamilyName')),
        "ERROR: INIT GRID",
      );
}
