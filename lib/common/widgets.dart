import 'package:fa_flutter_packages/common/colors.dart';
import 'package:fa_flutter_packages/common/dimensions.dart';
import 'package:fa_flutter_packages/common/icons.dart';
import 'package:fa_flutter_packages/common/textStyles.dart';
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


