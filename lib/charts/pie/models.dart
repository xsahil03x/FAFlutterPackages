import 'package:charts_flutter/flutter.dart' as charts;
import 'configs.dart';

class GaugeSegment {
  final String segment;
  final int size;
  final String value;
  final charts.Color color;

  const GaugeSegment({this.value, this.segment, this.size, this.color});

  factory GaugeSegment.sample() {
    return GaugeSegment(
        value: rng.nextInt(255).toString(),
        segment: createRandomString(8),
        size: 8,
        color: charts.Color(
            r: rng.nextInt(255), g: rng.nextInt(255), b: rng.nextInt(255)));
  }
}
