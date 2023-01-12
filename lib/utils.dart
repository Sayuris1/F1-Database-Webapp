import 'package:xml/xml.dart';

class Utils {
  static String firstOrNull(Iterable<XmlElement> iterable) {
    if (iterable.isEmpty) return "-1";
    return iterable.single.text;
  }

  static XmlElement findAndfirst(XmlElement iterable, String elementName) {
    return iterable.findElements(elementName).first;
  }

  static String emptyIfNull(String? str) {
    if (str == null) return "";
    return str;
  }
}
