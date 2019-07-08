import 'package:fa_manager_flutter/repository/data_repository/quick_viz/models.dart';

class TableApiModel {
  final ChartDataItem dimension;
  final ChartDataItem dimension1;
  final ChartDataItem measure;

  const TableApiModel({this.dimension, this.dimension1, this.measure});

  factory TableApiModel.fromChartMetadata(Map<String, dynamic> map,
      String dimensionKey, String dimension1Key, String measureKey) {
    return TableApiModel(
      dimension: ChartDataItem.fromJson(map[dimensionKey]),
      dimension1: ChartDataItem.fromJson(map[dimension1Key]),
      measure: ChartDataItem.fromJson(map[measureKey]),
    );
  }
}

class TableModel {
  final Map<String, List<KuchRow>> map;
  final String title;

  const TableModel({this.map, this.title});

  List<String> get keys => map.keys.toList();
}

class KuchRow {
  final String name;
  final double value;
  final String valueDisplay;

  const KuchRow({
    this.name,
    this.value,
    this.valueDisplay,
  });
}
