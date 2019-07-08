import 'package:fa_flutter_packages/charts/bar/configs.dart';
import 'package:fa_flutter_packages/charts/bar/models.dart';
import 'package:fa_flutter_packages/charts/bar/widgets.dart';

class BarGraph extends StatefulWidget {
  final List<BarData> list;
  final double total;
  final bool shimmer;
  final String title;
  final String totalDisplay;
  final bool disableColor;

  const BarGraph({
    Key key,
    @required this.list,
    @required this.total,
    @required this.title,
    @required this.totalDisplay,
    this.shimmer = false,
    this.disableColor = false,
  })  : assert(list != null),
        assert(total != null),
        assert(title != null),
        assert(totalDisplay != null),
        super(key: key);

  @override
  State<BarGraph> createState() => new _WidgetState();
}

class _WidgetState extends State<BarGraph> {
  int _length;

  @override
  void initState() {
    super.initState();
    _length = widget.list.length < expansion_threshold
        ? widget.list.length
        : expansion_threshold;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: color_transparent,
      onTap: () => expand(),
      child: Column(children: [
        TotalRow(
          total: widget.total,
          totalDisplay: widget.totalDisplay,
        ),
        Expanded(
          child: Bars(
            list: widget.list,
            total: widget.total,
            shimmer: widget.shimmer,
            disableColor: widget.disableColor,
            physics: NeverScrollableScrollPhysics(),
            length: _length,
          ),
        ),
      ]),
    );
  }

  void expand() {
    Navigator.push(
      context,
      dialogPageRoute(
        builder: (_) => BarExpanded(
              list: widget.list,
              total: widget.total,
              title: widget.title,
              totalDisplay: widget.totalDisplay,
              disableColor: widget.disableColor,
            ),
      ),
    );
  }
}

class Bars extends StatelessWidget {
  final List<BarData> list;
  final double total;
  final int length;
  final ScrollPhysics physics;
  final double baseline;
  final bool shimmer;
  final bool disableColor;

  const Bars({
    Key key,
    @required this.list,
    @required this.total,
    @required this.length,
    this.shimmer = false,
    this.baseline = 64,
    this.disableColor = false,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: physics,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (context, index) {
        return ShimmerWrapper(
          shimmer: shimmer,
          child: LabelLinePercentage(
            baseLine: 16,
            color: list[index].color,
            label: list[index].title,
            disableColor: disableColor,
            score: list[index].score.toInt(),
            scoreDisplay: list[index].scoreDisplay,
            total: total != null ? total.toInt() : 0,
          ),
        );
      },
    );
  }
}

class BarExpanded extends StatelessWidget {
  final double total;
  final List<BarData> list;
  final String title;
  final bool disableColor;
  final String totalDisplay;

  const BarExpanded(
      {Key key,
      this.total,
      this.list,
      this.title,
      this.disableColor,
      this.totalDisplay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBack(
      title: title,
      child: Column(children: [
        Container(
          height: 16,
        ),
        TotalRow(
          total: total,
          totalDisplay: totalDisplay,
        ),
        Expanded(
          child: Bars(
            list: list,
            total: total,
            length: list.length,
            physics: scrollPhysics,
            disableColor: disableColor,
          ),
        ),
      ]),
    );
  }
}
