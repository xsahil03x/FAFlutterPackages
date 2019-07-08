import 'configs.dart';
import 'models.dart';
import 'widgets.dart';

class PieChart extends StatefulWidget {
  final List<GaugeSegment> list;
  final List<GaugeSegment> truncateList;
  final double total;
  final bool animate;
  final bool shimmer;
  final String title;
  final String action;

  const PieChart(
      {Key key,
      this.list,
      this.total,
      this.animate,
      this.shimmer = false,
      this.truncateList,
      this.title,
      this.action})
      : assert(list != null),
        assert(truncateList != null),
        assert(total != null),
        assert(title != null),
        super(key: key);

  @override
  State<PieChart> createState() => new _WidgetState();
}

class _WidgetState extends State<PieChart> {
  String _total, _name;

  @override
  void initState() {
    super.initState();
    _total = NumberSystem.parse(widget.total);
    _name = text_total;
  }

  itemClicked(String value, String name) async {
    if (name != text_other)
      setState(() {
        _total = value;
        _name = name;
      });
    else {
      expand();
    }
  }

  void expand() {
    Navigator.push(
      context,
      dialogPageRoute(
        builder: (_) => new PieChartExpanded(
              list: widget.list,
              title: widget.title,
              total: widget.total,
              action: widget.action,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        expand();
      },
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                ShimmerWrapper(
                  shimmer: widget.shimmer,
                  child: Pie(
                    list: widget.truncateList,
                    total: widget.total,
                  ),
                ),
                Center(
                  child: TotalView(
                    shimmer: widget.shimmer,
                    name: _name,
                    value: _name == text_total
                        ? NumberSystem.parse(widget.total)
                        : _total,
                    expanded: false,
                  ),
                )
              ],
            ),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: PieLegend(
              shimmer: widget.shimmer,
              list: widget.truncateList,
              itemClicked: itemClicked,
              total: widget.total,
            ),
          ),
        ],
      ),
    );
  }
}
