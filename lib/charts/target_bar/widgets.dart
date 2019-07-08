import 'package:fa_manager_flutter/helpers/number_system.dart';

import 'configs.dart';
import 'models.dart';

class RRR extends StatelessWidget {
  final double rrr;

  const RRR({Key key, this.rrr}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: rrr == null ? 0 : 1,
      child: Container(
        height: 14,
        width: 64,
        decoration: BoxDecoration(
            color: color_primaryLight,
            borderRadius: BorderRadius.circular(4.0)),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Center(
            child: Text(
              rrr.toStringAsFixed(1),
              style: textStyle_caption.copyWith(color: color_textBlackHigh),
            ),
          ),
        ),
      ),
    );
  }
}

class MeasureRow extends StatelessWidget {
  final int flexLeft;
  final int flexRight;
  final String rrr;

  const MeasureRow({Key key, this.flexLeft, this.flexRight, this.rrr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AlignExpanded(
          alignment: Alignment.bottomLeft,
          child: ShimmerWrapper(
            shimmer: TargetBars.of(context).shimmer,
            child: Text(
              text_target.toUpperCase(),
              style: textStyle_caption,
            ),
          ),
        ),
        CenterExpanded(
          child: ShimmerWrapper(
            shimmer: TargetBars.of(context).shimmer,
            child: Text(
              rrr.toUpperCase(),
              style: textStyle_caption,
            ),
          ),
        ),
        AlignExpanded(
          alignment: Alignment.bottomRight,
          child: ShimmerWrapper(
            shimmer: TargetBars.of(context).shimmer,
            child: Text(
              text_achvmnt.toUpperCase(),
              style: textStyle_caption,
            ),
          ),
        ),
      ],
    );
  }
}

class TargetTotalRow extends StatelessWidget {
  final TargetBarData total;
  final flexLeft, flexRight;
  final String rrr;

  const TargetTotalRow(
      {Key key, this.total, this.flexLeft, this.flexRight, this.rrr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: flexLeft,
              child: Container(),
            ),
            Expanded(
              flex: flexRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: MeasureRow(rrr: rrr),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: flexLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: ShimmerWrapper(
                  shimmer: TargetBars.of(context).shimmer,
                  child: Text(
                    total.name,
                    style: textStyle_titleRegular.copyWith(
                        color: color_textBlackMedium),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: flexRight,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                    child: Row(
                      children: [
                        AlignExpanded(
                          alignment: Alignment.bottomLeft,
                          child: ShimmerWrapper(
                            shimmer: TargetBars.of(context).shimmer,
                            child: Text(
                              NumberSystem.parse(total.target),
                              style: textStyle_titleRegular,
                            ),
                          ),
                        ),
                        CenterExpanded(
                          child: ShimmerWrapper(
                            shimmer: TargetBars.of(context).shimmer,
                            child: RRR(
                              rrr: total.percent,
                            ),
                          ),
                        ),
                        AlignExpanded(
                          alignment: Alignment.bottomRight,
                          child: ShimmerWrapper(
                            shimmer: TargetBars.of(context).shimmer,
                            child: Text(
                              NumberSystem.parse(total.achieved),
                              style: textStyle_titleLight,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                    child: ShimmerWrapper(
                      shimmer: TargetBars.of(context).shimmer,
                      child: LinePercentage(
                          score: total.percent.toInt(),
                          total: 100,
                          disableColor: true,
                          color: total.color),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class KuchKuch extends StatelessWidget {
  final TargetBarData item;

  const KuchKuch({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: contentAboveBarPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AlignExpanded(
                alignment: Alignment.bottomLeft,
                child: Text(
                  item.targetDisplay,
                  style: textStyle_bodyRegular,
                ),
              ),
              CenterExpanded(
                child: RRR(
                  rrr: item.percent,
                ),
              ),
              AlignExpanded(
                alignment: Alignment.bottomRight,
                child: Text(
                  item.achievedDisplay,
                  style: textStyle_caption,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: barPadding,
          child: LinePercentage(
            score: item.percent.toInt(),
            total: 100,
            color: item.color,
            disableColor: true,
          ),
        ),
      ],
    );
  }
}

class LabelLinePercentage extends StatelessWidget {
  final TargetBarData item;
  final flexLeft, flexRight;
  final bool expanded;

  const LabelLinePercentage({
    Key key,
    this.item,
    this.flexLeft,
    this.flexRight,
    this.expanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flexLeft,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              truncateString(item.name, enable: !expanded),
              style: textStyle_bodyLight,
            ),
          ),
        ),
        Expanded(
          flex: flexRight,
          child: KuchKuch(
            item: item,
          ),
        )
      ],
    );
  }
}

class KuchBars extends StatelessWidget {
  final List<TargetBarData> list;
  final int length;
  final ScrollPhysics physics;
  final flexLeft, flexRight;

  const KuchBars(
      {Key key,
      @required this.list,
      @required this.length,
      this.physics,
      this.flexLeft,
      this.flexRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (context, index) {
        return ShimmerWrapper(
          shimmer: TargetBars.of(context).shimmer,
          child: LabelLinePercentage(
            flexRight: flexRight,
            flexLeft: flexLeft,
            item: list[index],
          ),
        );
      },
    );
  }
}

class Graph extends StatelessWidget {
  final List<TargetBarData> list;
  final bool expanded;
  final String rrr;
  final flexLeft = 1, flexRight = 2;

  final String title;

  TargetBarData get total {
    double target = 0;
    double achieved = 0;
    list.forEach((a) {
      target = target + a.target;
      achieved = achieved + a.achieved;
    });
    double percent =
        achieved > target ? 100 : target == 0 ? 0 : achieved / target * 100;
    return TargetBarData(
        name: text_total,
        target: target,
        achieved: achieved,
        percent: percent,
        color: color_greenLight);
  }

  const Graph(
      {Key key,
      @required this.list,
      @required this.title,
      this.expanded,
      this.rrr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TargetTotalRow(
        rrr: rrr,
        flexLeft: flexLeft,
        flexRight: flexRight,
        total: total,
      ),
      SizedBox(
        height: 12,
      ),
      Expanded(
        child: KuchBars(
          flexRight: flexRight,
          flexLeft: flexLeft,
          list: list,
          physics: expanded ? scrollPhysics : NeverScrollableScrollPhysics(),
          length: expanded || list.length < expansionThreshold
              ? list.length
              : expansionThreshold,
        ),
      ),
      CardExpandIcon(
        opacity: expanded,
      ),
    ]);
  }
}

class TargetBars extends InheritedWidget {
  final bool shimmer;

  const TargetBars({this.shimmer, child}) : super(child: child);

  @override
  bool updateShouldNotify(TargetBars oldWidget) {
    return shimmer != oldWidget.shimmer;
  }

  static TargetBars of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(TargetBars);
  }
}
