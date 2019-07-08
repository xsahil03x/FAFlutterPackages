import 'package:fa_flutter_packages/fa_flutter_packages.dart';

List<BarData> getDummyBarData() {
  return List.generate(10, (x) => BarData.sample()).toList();
}

List<GaugeSegment> getGaugeSegmentData() {
  return List.generate(12, (x) => GaugeSegment.sample()).toList();
}
