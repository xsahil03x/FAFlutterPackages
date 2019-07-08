import 'package:fa_manager_flutter/helpers/number_system.dart';

import 'configs.dart';
import 'models.dart';

class RRR extends StatelessWidget {
  final String rrr;

  const RRR({Key key, this.rrr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return rrr == null
        ? Container()
        : Container(
            height: 14,
            width: 64,
            decoration: BoxDecoration(
                color: color_primaryLight,
                borderRadius: BorderRadius.circular(radius)),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Center(
                child: Text(
                  rrr,
                  style: textStyle_subOverlineLight.copyWith(
                      color: color_textBlackHigh),
                ),
              ),
            ),
          );
  }
}

class TargetPercentage extends StatelessWidget {
  final TargetModel target;
  final bool shimmer;

  const TargetPercentage({Key key, this.target, this.shimmer})
      : assert(target != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: contentAboveBarPadding,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ShimmerWrapper(
                    shimmer: shimmer,
                    child: Text(
                      target.targetDisplay ?? '',
                      style: textStyle_bodyRegular,
                    ),
                  ),
                ),
              ),
              CenterExpanded(
                child: ShimmerWrapper(
                  shimmer: shimmer,
                  child: RRR(
                    rrr: target.requiredRateDisplay,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ShimmerWrapper(
                    shimmer: shimmer,
                    child: Text(
                      target.achDisplay ?? '',
                      style: textStyle_caption,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: barPadding,
          child: ShimmerWrapper(
            shimmer: shimmer,
            child: LinePercentage(
              score: target.targetAchieved
                  ? target.target.toInt()
                  : target.ach.toInt(),
              total: target.target.toInt(),
              color: target.color,
              disableColor: true,
            ),
          ),
        ),
      ],
    );
  }
}

class TargetRow extends StatelessWidget {
  final int leftFlex;
  final int rightFlex;
  final TargetModel target;
  final bool shimmer;

  const TargetRow(
      {Key key, this.leftFlex, this.rightFlex, this.target, this.shimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: leftFlex,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ShimmerWrapper(
                shimmer: shimmer,
                child: Text(
                  target.name,
                  style: textStyle_bodyLight,
                ),
              ),
            ),
          ),
          Expanded(
            flex: rightFlex,
            child: TargetPercentage(
              target: target,
              shimmer: shimmer,
            ),
          ),
        ],
      ),
    );
  }
}

class HighlightedRow extends StatelessWidget {
  final List<TargetModel> targets;
  final int leftFlex;
  final int rightFlex;
  final bool shimmer;

  TargetModel get row {
    double target = 0;
    double rrr = 0;
    double ach = 0;
    targets.forEach((a) {
      target = target + a.target;
      rrr = rrr + a.requiredRate;
      ach = ach + a.ach;
    });
    rrr = targets != null && targets.length != 0 ? rrr / targets.length : 0;
    return TargetModel(
      color: color_greenLight,
      name: text_total,
      target: target,
      requiredRate: rrr,
      ach: ach,
    );
  }

  const HighlightedRow(
      {Key key, this.targets, this.leftFlex, this.rightFlex, this.shimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: leftFlex,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ShimmerWrapper(
              shimmer: shimmer,
              child: Text(
                text_total,
                style: textStyle_titleRegular.copyWith(color: color_textBlackMedium),
              ),
            ),
          ),
        ),
        Expanded(
          flex: rightFlex,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 12, 4),
                child: Row(
                  children: [
                    AlignExpanded(
                      alignment: Alignment.bottomLeft,
                      child: ShimmerWrapper(
                        shimmer: shimmer,
                        child: Text(
                          NumberSystem.parse(row.target),
                          style: textStyle_titleRegular,
                        ),
                      ),
                    ),
                    CenterExpanded(
                      child: ShimmerWrapper(
                        shimmer: shimmer,
                        child: RRR(
                          rrr: row.requiredRateDisplay,
                        ),
                      ),
                    ),
                    AlignExpanded(
                      alignment: Alignment.bottomRight,
                      child: ShimmerWrapper(
                        shimmer: shimmer,
                        child: Text(
                          NumberSystem.parse(row.ach),
                          style: textStyle_titleLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 8, 8),
                child: ShimmerWrapper(
                  shimmer: shimmer,
                  child: LinePercentage(
                    score: row.targetAchieved
                        ? row.target.toInt()
                        : row.ach.toInt(),
                    total: row.target.toInt(),
                    color: row.color,
                    disableColor: true,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MeasureRow extends StatelessWidget {
  final int flexLeft;
  final int flexRight;
  final bool shimmer;

  const MeasureRow({Key key, this.flexLeft, this.flexRight, this.shimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flexLeft,
          child: Container(),
        ),
        Expanded(
          flex: flexRight,
          child: Row(
            children: [
              AlignExpanded(
                alignment: Alignment.bottomLeft,
                child: ShimmerWrapper(
                  shimmer: shimmer,
                  child: Text(
                    text_target.toUpperCase(),
                    style: textStyle_caption,
                  ),
                ),
              ),
              CenterExpanded(
                child: ShimmerWrapper(
                  shimmer: shimmer,
                  child: Text(
                    text_rrr_day.toUpperCase(),
                    style: textStyle_caption,
                  ),
                ),
              ),
              AlignExpanded(
                alignment: Alignment.bottomRight,
                child: ShimmerWrapper(
                  shimmer: shimmer,
                  child: Text(
                    text_achvmnt.toUpperCase(),
                    style: textStyle_caption,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
