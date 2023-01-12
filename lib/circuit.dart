import "utils.dart";
import 'package:xml/xml.dart';

class Circuit {
  final String name;
  final String locality;
  final String country;

  Circuit(this.name, this.locality, this.country);

  factory Circuit.fromXmlElement(XmlElement xmlElement) => Circuit(
      Utils.firstOrNull(xmlElement.findElements('CircuitName')),
      Utils.firstOrNull(
          Utils.findAndfirst(xmlElement, "Location").findElements('Locality')),
      Utils.firstOrNull(
          Utils.findAndfirst(xmlElement, "Location").findElements('Country')));
}
