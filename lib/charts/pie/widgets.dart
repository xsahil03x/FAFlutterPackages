import 'dart:math' as math;

import 'package:charts_flutter/flutter.dart' as charts;

import 'configs.dart';
import 'models.dart';

class Dot extends StatelessWidget {
  final int r, g, b, a;

  const Dot({Key key, this.r, this.g, this.b, this.a}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2 * radius,
      height: 2 * radius,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Color.fromARGB(a, r, g, b)),
    );
  }
}

class Pie extends StatefulWidget {
  final List<GaugeSegment> list;
  final double total;
  final bool animate;
  final bool expanded;

  List<charts.Series> get input {
    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => segment.color,
        data: list,
      )
    ];
  }

  const Pie(
      {Key key,
      this.list,
      this.animate = false,
      this.total,
      this.expanded = false})
      : assert(list != null),
        assert(total != null),
        super(key: key);

  @override
  State<Pie> createState() => new _WidgetStatePieChart();
}

class _WidgetStatePieChart extends State<Pie> {
  @override
  Widget build(BuildContext context) {
    return charts.PieChart(widget.input,
        animate: widget.animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 5, startAngle: 0, arcLength: 2 * math.pi));
  }
}

class PieLegend extends StatelessWidget {
  final List<GaugeSegment> list;
  final bool expanded;
  final ItemClicked itemClicked;
  final bool shimmer;
  final double total;

  const PieLegend({
    Key key,
    this.itemClicked,
    this.expanded = false,
    this.shimmer = false,
    @required this.list,
    @required this.total,
  })  : assert(list != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: expanded ? scrollPhysics : NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        var data = list[index];
        return Padding(
          padding:
              expanded ? EdgeInsets.all(16.0) : EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ShimmerWrapper(
                    shimmer: shimmer,
                    child: Dot(
                        a: data.color.a,
                        r: data.color.r,
                        g: data.color.g,
                        b: data.color.b),
                  ),
                  ShimmerWrapper(
                    shimmer: shimmer,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        truncateString(data.segment, enable: !expanded),
                        style: textStyle_bodyLight,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  ShimmerWrapper(
                    child: Text(
                      data.value,
                      style: textStyle_bodyRegular,
                    ),
                  ),
                  OpacityWithoutSpace(
                    opacity: expanded,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        (data.size / total * 100).toStringAsFixed(0) + '%',
                        style: textStyle_captionNumber.copyWith(
                            color: color_textBlackMedium),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TotalView extends StatelessWidget {
  final String value;
  final String name;
  final bool expanded;
  final bool shimmer;

  const TotalView(
      {Key key,
      this.value,
      this.name,
      this.expanded = false,
      this.shimmer = false})
      : assert(value != null),
        assert(name != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      shimmer: shimmer,
      child: Column(
        children: [
          AlignExpanded(
            alignment: Alignment.bottomCenter,
            child: Text(
              name,
              style: textStyle_bodyLight.copyWith(color: color_textBlackMedium),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(expanded ? 32 : 16),
            child: Container(
              height: 0.1,
              width: expanded ? 128 : 64,
              color: color_secondary,
            ),
          ),
          AlignExpanded(
            alignment: Alignment.topCenter,
            child: Text(
              value,
              style: textStyle_bodyRegular,
            ),
          ),
        ],
      ),
    );
  }
}

class PieChartExpanded extends StatefulWidget {
  final List<GaugeSegment> list;
  final double total;
  final String title;
  final String action;

  const PieChartExpanded(
      {Key key, this.list, this.total, this.title, this.action})
      : assert(list != null),
        assert(total != null),
        assert(title != null),
        super(key: key);

  @override
  State<PieChartExpanded> createState() => new _WidgetStatePE();
}

class _WidgetStatePE extends State<PieChartExpanded> {
  String _total, _name;

  @override
  void initState() {
    super.initState();
    _total = NumberSystem.parse(widget.total);
    _name = text_total;
  }

  itemClicked(String value, String name) async {
    setState(() {
      _total = value;
      _name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBack(
      title: widget.title,
      action: widget.action,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(children: [
              Pie(
                list: widget.list,
                expanded: true,
                total: widget.total,
              ),
              Center(
                child: TotalView(
                  name: _name,
                  value: _total,
                  expanded: true,
                ),
              )
            ]),
          ),
          Expanded(
            flex: 3,
            child: PieLegend(
              expanded: true,
              itemClicked: itemClicked,
              list: widget.list,
              total: widget.total,
            ),
          ),
        ],
      ),
    );
  }
}
