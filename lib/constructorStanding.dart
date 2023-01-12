import "utils.dart";
import 'package:xml/xml.dart';

class ConstructorStanding {
  final String points;
  final String wins;
  final String name;
  final String nationality;

  ConstructorStanding(this.points, this.wins, this.name, this.nationality);

  factory ConstructorStanding.fromXmlElement(XmlElement xmlElement) =>
      ConstructorStanding(
        Utils.emptyIfNull(xmlElement.getAttribute('points')),
        Utils.emptyIfNull(xmlElement.getAttribute('wins')),
        Utils.firstOrNull(
            Utils.findAndfirst(xmlElement, "Constructor").findElements('Name')),
        Utils.firstOrNull(Utils.findAndfirst(xmlElement, "Constructor")
            .findElements('Nationality')),
      );
}
