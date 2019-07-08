import 'configs.dart';

class TargetModel {
  final String name;
  final double target;
  final String targetDisplay;
  final double requiredRate;
  final String requiredRateDisplay;
  final double ach;
  final String achDisplay;
  final double percentAchieved;
  final Color color;

  bool get targetAchieved => ach >= target;

  const TargetModel({
    this.name,
    this.target,
    this.requiredRate,
    this.ach,
    this.percentAchieved = 0,
    this.targetDisplay,
    this.requiredRateDisplay,
    this.achDisplay,
    this.color,
  });

  factory TargetModel.fromJson(Map<String, dynamic> map, Color color) {
    double rrr = 0;
    try {
      rrr = map['RequiredRate']?.toDouble();
    } catch (e) {
      rrr = 0;
    }
    return TargetModel(
      name: map['PrimaryCategory'] ?? '',
      target: map['Target']?.toDouble() ?? 0,
      targetDisplay: map['Target_Display'] ?? '0',
      requiredRate: rrr,
      requiredRateDisplay: map['RequiredRate_Display'] ?? '0',
      ach: (map['Achievements']?.toDouble() ?? 0),
      achDisplay: map['Achievements_Display'] ?? '0',
      color: color,
    );
  }
}
