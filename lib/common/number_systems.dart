import 'package:intl/intl.dart';

final pattern = new NumberFormat('##,###', 'en_US');
const decimalPlace = 1;

class NumberSystem {
  static String parse(double val) {
    val = val ?? 0;
    var stringVal = '';
    if (val >= 10000000000) {
      var div = (val / 10000000).toStringAsFixed(decimalPlace);
      stringVal = pattern.format(div) + ' Cr.';
    } else if (val >= 10000000) {
      var div = (val / 10000000).toStringAsFixed(decimalPlace);
      stringVal = div.toString() + ' Cr.';
    } else if (val >= 100000) {
      var div = (val / 100000).toStringAsFixed(decimalPlace);
      stringVal = div.toString() + ' Lac';
    } else if (val >= 1000) {
      stringVal = pattern.format(val);
    } else if (val < 1) {
      var div = val.toStringAsFixed(decimalPlace);
      stringVal = div.toString();
    } else if (val < 100) {
      var div = val.toStringAsFixed(1);
      stringVal = div.toString();
    } else {
      var div = val.toStringAsFixed(0);
      stringVal = div.toString();
    }
    return stringVal;
  }
}