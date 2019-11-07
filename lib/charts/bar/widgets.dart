import 'package:fa_flutter_packages/charts/bar/configs.dart';

class LabelLinePercentage extends StatelessWidget {
  final String label;
  final int score;
  final String scoreDisplay;
  final int total;
  final Color color;
  final bool shimmer;
  final double baseLine;
  final bool disableColor;
  final int animateDuration;

  const LabelLinePercentage({
    Key key,
    @required this.label,
    @required this.score,
    @required this.total,
    @required this.color,
    @required this.scoreDisplay,
    this.shimmer = false,
    this.baseLine = 64,
    this.disableColor = false,
    this.animateDuration,
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
              ShimmerWrapper(
                shimmer: shimmer,
                child: Text(
                  label,
                  style: textStyle_bodyLight,
                ),
              ),
              ShimmerWrapper(
                shimmer: shimmer,
                child: Text(
                  scoreDisplay,
                  style: textStyle_bodyRegular,
                ),
              ),
            ],
          ),
        ),
        ShimmerWrapper(
          shimmer: shimmer,
          child: Padding(
            padding: barPadding,
            child: LinePercentage(
              score: score,
              total: total,
              color: color,
              disableColor: disableColor,
              animateDuration: animateDuration,
            ),
          ),
        ),
      ],
    );
  }
}

class TotalRow extends StatelessWidget {
  final double total;
  final String totalDisplay;
  final bool shimmer;

  const TotalRow({
    Key key,
    @required this.total,
    this.totalDisplay,
    this.shimmer = false,
  })  : assert(total != null),
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
          ShimmerWrapper(
            shimmer: shimmer,
            child: Text(
              text_total,
              style:
                  textStyle_titleRegular.copyWith(color: color_textBlackMedium),
            ),
          ),
          ShimmerWrapper(
            shimmer: shimmer,
            child: Text(
              totalDisplay,
              style:
                  textStyle_titleRegular.copyWith(color: color_textBlackHigh),
            ),
          ),
        ],
      ),
    );
  }
}
