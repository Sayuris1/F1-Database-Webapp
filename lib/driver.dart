import "utils.dart";
import 'package:xml/xml.dart';

class Driver {
  final int permanentNumber;
  final String givenName;
  final String familyName;
  final String dateOfBirth;
  final String nationality;
  final String driverId;
  int totalWin;
  int totalPoint;

  Driver(
      this.permanentNumber,
      this.givenName,
      this.familyName,
      this.dateOfBirth,
      this.nationality,
      this.driverId,
      this.totalWin,
      this.totalPoint);

  factory Driver.fromXmlElement(XmlElement xmlElement) => Driver(
      int.parse(Utils.firstOrNull(xmlElement.findElements('PermanentNumber'))),
      Utils.firstOrNull(xmlElement.findElements('GivenName')),
      Utils.firstOrNull(xmlElement.findElements('FamilyName')),
      Utils.firstOrNull(xmlElement.findElements('DateOfBirth')),
      Utils.firstOrNull(xmlElement.findElements('Nationality')),
      Utils.emptyIfNull(xmlElement.getAttribute('driverId')),
      0,
      0);

  String GetNumber() {
    if (permanentNumber == -1) return " ";
    return "#" + permanentNumber.toString();
  }

  @override
  String toString() {
    return 'Given Name: $givenName, '
        'Family Name: $familyName, '
        'Date of Birth: $dateOfBirth, '
        'Nationality: $nationality, '
        'Number: $permanentNumber, ';
  }
}
