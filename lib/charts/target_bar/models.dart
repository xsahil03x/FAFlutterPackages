import 'configs.dart';

class TargetBarData {
  const TargetBarData(
      {this.targetDisplay,
      this.achievedDisplay,
      this.name,
      this.target,
      this.achieved,
      this.percent,
      this.color});

  final String name;
  final double target;
  final String targetDisplay;
  final double achieved;
  final String achievedDisplay;
  final double percent;
  final Color color;

  @override
  String toString() => 'name: $name, achievedPercent: $percent';
}
