import "utils.dart";
import 'package:xml/xml.dart';

class Constructor {
  final String name;
  final String nationality;
  List<String> drivers;

  Constructor(this.name, this.nationality, this.drivers);

  factory Constructor.fromXmlElement(XmlElement xmlElement) => Constructor(
      Utils.firstOrNull(xmlElement.findElements('Name')),
      Utils.firstOrNull(xmlElement.findElements('Nationality')), []);
}
