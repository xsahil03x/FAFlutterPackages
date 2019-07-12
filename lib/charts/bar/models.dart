import 'package:fa_flutter_packages/charts/bar/configs.dart';

class BarData {
  final String title;
  final double score;
  final String scoreDisplay;
  final Color color;

  const BarData({this.title, this.score, this.color, this.scoreDisplay});

  @override
  String toString() => 'title: $title, score: $score';

  factory BarData.sample() {
    final score = rng.nextInt(2000).toDouble();
    return BarData(
        title: createRandomString(8),
        score: score,
        color: rngColor,
        scoreDisplay: score.toString());
  }
}
