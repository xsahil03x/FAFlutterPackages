import 'package:fa_flutter_packages/fa_flutter_packages.dart';

List<BarData> getDummyBarData() {
  List<BarData> data = List<BarData>();
  for (int i = 0; i < 10; i++) data.add(BarData.sample());
  return data;
}

List<GaugeSegment> getGaugeSegmentData() {
  List<GaugeSegment> data = List<GaugeSegment>();
  for (int i = 0; i < 12; i++) data.add(GaugeSegment.sample());
  return data;
}
