import 'configs.dart';
import 'models.dart';
import 'widgets.dart';

class TargetBarGraph extends StatelessWidget {
  final List<TargetBarData> list;
  final String rrr;
  final String title;
  final bool shimmer;

  const TargetBarGraph(
      {Key key,
      this.shimmer = false,
      @required this.list,
      @required this.title,
      this.rrr = text_sym_percent})
      : assert(list != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TargetBars(
      shimmer: shimmer,
      child: InkWell(
        onTap: () {
          if (!shimmer)
            Navigator.push(
              context,
              dialogPageRoute(
                builder: (_) => TargetBarExpanded(
                      title: title,
                      list: list,
                      rrr: rrr,
                    ),
              ),
            );
        },
        child: Graph(
          list: list,
          rrr: rrr,
          title: title,
          expanded: false,
        ),
      ),
    );
  }
}

class TargetBarExpanded extends StatelessWidget {
  final List<TargetBarData> list;
  final String rrr;
  final String title;
  final bool shimmer;

  const TargetBarExpanded(
      {Key key, this.list, this.title, this.rrr, this.shimmer})
      : assert(list != null),
        assert(rrr != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBack(
      title: title,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TargetBars(
          shimmer: shimmer,
          child: Graph(
            rrr: rrr,
            title: title,
            list: list,
            expanded: true,
          ),
        ),
      ),
    );
  }
}
