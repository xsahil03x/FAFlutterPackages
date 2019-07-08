import 'package:fa_manager_flutter/repository/data_repository/quick_viz/models.dart';

import 'configs.dart';

class TwoNumberData {
  final String number1;
  final String number2;
  final String title1;
  final String title2;

  const TwoNumberData({this.number1, this.number2, this.title1, this.title2});

  factory TwoNumberData.sample() {
    return TwoNumberData(number1: '0', number2: '0', title1: '', title2: '');
  }

  factory TwoNumberData.fromMetaData(List<dynamic> data, String key1,
      String key2, String key1Nomenclature, String key2Nomenclature) {
    var data1 = data[0][key1] ?? data[1][key1];
    var number1 = ChartDataItem.fromJson(data1);
    var data2 = data[0][key2] ?? data[1][key2];
    var number2 = ChartDataItem.fromJson(data2);
    return TwoNumberData(
        number1: number1.display,
        number2: number2.display,
        title1: key1Nomenclature,
        title2: key2Nomenclature);
  }
}

class OneNumberData {
  final String number;

  const OneNumberData({this.number});

  factory OneNumberData.sample() {
    return OneNumberData(number: '0');
  }

  factory OneNumberData.fromMetaData(String key, List<dynamic> data) {
    Logger.flow('one number data $key');
    return OneNumberData(number: ChartDataItem.fromJson(data[0][key]).display);
  }
}

class KpiGraphData {
  final String value; //assumption that value will be always numeric.
  final String leftValue;
  final String leftTitle;
  final String rightValue;
  final String rightTitle;
  final String unit;

  bool get progress => double.tryParse(value) >= 0;

  const KpiGraphData(
      {this.unit,
      this.value,
      this.leftValue,
      this.leftTitle,
      this.rightValue,
      this.rightTitle});

  factory KpiGraphData.sample() {
    return KpiGraphData(
      value: '0',
      unit: '%',
      leftValue: '0',
      leftTitle: text_mtd_sales,
      rightValue: '0',
      rightTitle: text_mtd_sales,
    );
  }

  factory KpiGraphData.fromMetadata(List<dynamic> data, String key) {
    var data1 = data[0][key] ?? data[1][key] ?? data[2][key];
    var number1 = ChartDataItem.fromJson(data1);
    var data2 = data[0]['CurrentValue'] ??
        data[1]['CurrentValue'] ??
        data[2]['CurrentValue'];
    var number2 = ChartDataItem.fromJson(data2);
    var data3 = data[0]['PreviousValue'] ??
        data[1]['PreviousValue'] ??
        data[2]['PreviousValue'];
    var number3 = ChartDataItem.fromJson(data3);
    return KpiGraphData(
        value: number1.display,
        unit: '%',
        leftTitle: text_mtd_sales,
        leftValue: number2.display,
        rightTitle: text_lmtd_sales,
        rightValue: number3.display);
  }
}
