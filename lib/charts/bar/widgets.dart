import 'package:fa_flutter_packages/charts/bar/configs.dart';

class LabelLinePercentage extends StatelessWidget {
  final String label;
  final int score;
  final String scoreDisplay;
  final int total;
  final Color color;
  final double baseLine;
  final bool disableColor;

  const LabelLinePercentage({
    Key key,
    @required this.label,
    @required this.score,
    @required this.total,
    @required this.color,
    @required this.scoreDisplay,
    this.baseLine = 64,
    this.disableColor = false,
  })  : assert(label != null),
        assert(score != null),
        assert(total != null),
        assert(color != null),
        assert(scoreDisplay != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: contentAboveBarPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: textStyle_bodyLight,
              ),
              Text(
                scoreDisplay,
                style: textStyle_bodyRegular,
              ),
            ],
          ),
        ),
        Padding(
          padding: barPadding,
          child: LinePercentage(
            score: score,
            total: total,
            color: color,
            disableColor: disableColor,
          ),
        ),
      ],
    );
  }
}

class TotalRow extends StatelessWidget {
  final double total;
  final String totalDisplay;

  const TotalRow({Key key, @required this.total, this.totalDisplay})
      : assert(total != null),
        assert(total != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 8, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text_total,
            style:
                textStyle_titleRegular.copyWith(color: color_textBlackMedium),
          ),
          Text(
            totalDisplay,
            style: textStyle_titleRegular.copyWith(color: color_textBlackHigh),
          ),
        ],
      ),
    );
  }
}
