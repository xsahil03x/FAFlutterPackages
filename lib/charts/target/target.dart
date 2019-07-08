import 'configs.dart';
import 'models.dart';
import 'widgets.dart';

class TargetVsAchievementChart extends StatelessWidget {
  final Map<String, List<TargetModel>> data;
  final String title;
  final bool shimmer;
  final int flexLeft = 1;
  final int flexRight = 2;

  const TargetVsAchievementChart({Key key, this.data, this.title, this.shimmer})
      : super(key: key);

  Widget totalRowBuilder(List<TargetModel> targets) => HighlightedRow(
        rightFlex: flexRight,
        leftFlex: flexLeft,
        targets: targets,
        shimmer: shimmer,
      );

  Widget rowBuilder(TargetModel item) => TargetRow(
        rightFlex: flexRight,
        leftFlex: flexLeft,
        target: item,
        shimmer: shimmer,
      );

  @override
  Widget build(BuildContext context) {
    return FullPageGenericChart<TargetModel>(
      map: data,
      title: title,
      flexLeft: flexLeft,
      totalRowBuilder: totalRowBuilder,
      flexRight: flexRight,
      rowBuilder: rowBuilder,
      shimmer: shimmer,
      measureRow: MeasureRow(
          flexLeft: flexLeft, flexRight: flexRight, shimmer: shimmer),
    );
  }
}
