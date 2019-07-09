import 'package:fa_flutter_packages/common/colors.dart';
import 'package:fa_flutter_packages/common/dimensions.dart';
import 'package:fa_flutter_packages/common/icons.dart';
import 'package:fa_flutter_packages/common/text.dart';
import 'package:fa_flutter_packages/common/textStyles.dart';
import 'package:fa_flutter_packages/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScaffoldWithBack extends StatelessWidget {
  final Widget child;
  final String title;
  final String subTitle;
  final String action;

  const ScaffoldWithBack(
      {Key key, this.child, this.title, this.subTitle = '', this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            OpacityWithoutSpace(
              opacity: action != null && action.length > 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                      border: Border.all(color: color_white_alpha),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        action ?? '',
                        style: textStyle_caption.copyWith(
                            color: color_textWhiteHigh),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OpacityWithoutSpace(
                opacity: title != null && title.length > 0,
                child: Text(
                  title ?? '',
                  style: textStyle_title2.copyWith(color: color_textWhiteHigh),
                ),
              ),
              OpacityWithoutSpace(
                opacity: subTitle != null && subTitle.length > 0,
                child: Text(
                  subTitle ?? '',
                  style: textStyle_bodyLight.copyWith(
                      color: color_textWhiteMedium),
                ),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              icBack,
              color: color_white,
            ),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: child,
    );
  }
}

class OpacityWithoutSpace extends StatelessWidget {
  final Widget child;
  final bool opacity;

  const OpacityWithoutSpace(
      {Key key, @required this.opacity, @required this.child})
      : assert(opacity != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => opacity ? child : Container();
}

class ShimmerWrapper extends StatelessWidget {
  final Widget child;
  final bool shimmer;

  const ShimmerWrapper({Key key, this.child, this.shimmer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return shimmer ?? false
        ? AppShimmer(
            child: child,
          )
        : child;
  }
}

class AppShimmer extends StatelessWidget {
  final Widget child;

  const AppShimmer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        child: child,
        baseColor: color_shimmer_base,
        highlightColor: color_shimmer);
  }
}

class CardTitle extends StatelessWidget {
  final String title;
  final bool mtd;
  final String unit;

  const CardTitle({Key key, @required this.title, this.mtd = false, this.unit})
      : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyle_titleLight,
            ),
            Opacity(
              opacity: mtd ? 1 : 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: new BoxDecoration(
                  border: Border.all(color: color_grey_extra),
                ),
                child: Text(
                  unit.length > 0 ? unit : text_mtd.toUpperCase(),
                  style: textStyle_subOverlineRegular.copyWith(
                      color: color_secondary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final double height;
  final Widget child;
  final bool shimmer;
  final EdgeInsets contentPadding;

  const AppCard(
      {Key key,
      this.child = const Placeholder(),
      this.height,
      this.contentPadding = const EdgeInsets.fromLTRB(2, 0, 2, 0),
      this.shimmer = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var network = Provider.of<ConnectivityResult>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Container(
        height: height,
        child: Card(
          shape: cardShape,
          elevation: cardElevation,
          color: color_white,
          child: shimmer
              ? AppShimmer(child: child)
              : Padding(
                  padding: contentPadding,
                  child: child,
                ),
        ),
      ),
    );
  }
}

class CardExpandIcon extends StatelessWidget {
  final bool opacity;
  final double height;

  const CardExpandIcon({Key key, this.opacity = true, this.height = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity ? 1 : 0,
      child: Container(
        height: height,
        child: Center(
            child: Icon(
          icExpandable,
          color: color_grey,
        )),
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  final Widget child;
  final String title;
  final double height;
  final String tag;
  final bool expandable;
  final bool mtd;
  final String unit;

  const HomePageCard({
    Key key,
    this.title = '',
    this.child = const Placeholder(),
    this.tag = "tag",
    this.height = homeCardHeight,
    this.expandable = false,
    this.mtd = false,
    this.unit = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      height: height,
      child: Column(
        children: [
          CardTitle(
            title: title,
            mtd: mtd,
            unit: unit,
          ),
          Expanded(child: child),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CardExpandIcon(
              height: 8,
              opacity: expandable,
            ),
          ),
        ],
      ),
    );
  }
}

class LinePercentage extends StatelessWidget {
  final int score;
  final int total;
  final Color color;
  final bool disableColor;

  const LinePercentage({
    Key key,
    @required this.score,
    @required this.total,
    @required this.color,
    this.disableColor = false,
  })  : assert(score != null),
        assert(total != null),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: score,
          child: Container(
            height: linePercentageHeight,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
            ),
          ),
        ),
        Expanded(
          flex: total - score,
          child: Container(
            height: linePercentageHeight,
            decoration: BoxDecoration(
                color: disableColor
                    ? linePercentageDisableColor
                    : color_transparent),
          ),
        )
      ],
    );
  }
}

class AlignExpanded extends StatelessWidget {
  final Widget child;
  final Alignment alignment;

  const AlignExpanded({Key key, this.child, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Align(alignment: alignment, child: child),
    );
  }
}
