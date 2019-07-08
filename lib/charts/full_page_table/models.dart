import 'package:fa_manager_flutter/repository/data_repository/quick_viz/models.dart';

class Measure {
  final String name;
  final String unit;

  Measure(this.name, this.unit);

  factory Measure.parse(String input) {
    String name = '';
    String unit = '';
    if (input != null)
      for (var i = 0; i < input.length; i++) {
        var start = input.indexOf('(');
        var end = input.indexOf(')');
        name = start > 0 ? input.substring(0, start - 1) : input;
        unit = start > 0 && end > start ? input.substring(start + 1, end) : '';
      }
    return Measure(name, unit);
  }
}

class FullPageApiModel {
  final ChartDataItem dimension;
  final ChartDataItem dimension1;
  final ChartDataItem measure;
  final ChartDataItem measure1;
  final ChartDataItem measure2;

  const FullPageApiModel(
      {this.dimension,
      this.dimension1,
      this.measure,
      this.measure1,
      this.measure2});

  factory FullPageApiModel.fromMetadata(
      Map<String, dynamic> map,
      String dimensionKey,
      String dimension1Key,
      String measureKey,
      String measure1Key,
      String measure2Key) {
    return FullPageApiModel(
      dimension: ChartDataItem.fromJson(map[dimensionKey]),
      dimension1: ChartDataItem.fromJson(map[dimension1Key]),
      measure: ChartDataItem.fromJson(map[measureKey]),
      measure1: ChartDataItem.fromJson(map[measure1Key]),
      measure2: ChartDataItem.fromJson(map[measure2Key]),
    );
  }
}

class SimpleRow {
  final String name;
  final double measure;
  final double measure1;
  final double measure2;
  final String measureDisplay;
  final String measure1Display;
  final String measure2Display;

  const SimpleRow(this.name, this.measure, this.measure1, this.measure2,
      this.measureDisplay, this.measure1Display, this.measure2Display);
}

class FullPageTableModel {
  final Map<String, List<SimpleRow>> map;
  final Measure measure;
  final Measure measure1;
  final Measure measure2;

  List<String> get keys => map.keys.toList();

  FullPageTableModel({this.map, this.measure, this.measure1, this.measure2});
}
