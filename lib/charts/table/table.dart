import 'configs.dart';
import 'models.dart';
import 'widgets.dart';

class TableChart extends StatelessWidget {
  final TableModel data;
  final String title;

  const TableChart({Key key, this.data, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          dialogPageRoute(
            builder: (_) => ChartExpanded(
                  data: data,
                  title: title,
                ),
          ),
        );
      },
      child: Chart(
        data: data,
        expanded: false,
      ),
    );
  }
}
