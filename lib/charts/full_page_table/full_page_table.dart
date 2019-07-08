import 'package:flutter/material.dart';

import 'configs.dart';
import 'models.dart';
import 'widgets.dart';

class FullPageGenericChart<T> extends StatelessWidget {
  final Map<String, List<T>> map;
  final String title;
  final Widget measureRow;
  final TotalRowBuilder<T> totalRowBuilder;
  final RowBuilder<T> rowBuilder;
  final int flexLeft;
  final int flexRight;
  final bool shimmer;

  const FullPageGenericChart(
      {Key key,
      this.title,
      this.map,
      this.measureRow,
      this.totalRowBuilder,
      this.rowBuilder,
      this.flexLeft,
      this.flexRight,
      this.shimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          dialogPageRoute(
            builder: (_) => TableChartExpanded<T>(
                  map: map,
                  title: title,
                  shimmer: shimmer,
                  flexLeft: flexLeft,
                  totalRow: totalRowBuilder,
                  flexRight: flexRight,
                  rowBuilder: rowBuilder,
                  measureRow: measureRow,
                ),
          ),
        );
      },
      child: TableInheritedWidget(
        shimmer: shimmer,
        child: TableChart<T>(
          map: map,
          flexLeft: flexLeft,
          totalRowBuilder: totalRowBuilder,
          flexRight: flexRight,
          rowBuilder: rowBuilder,
          measureRow: measureRow,
        ),
      ),
    );
  }
}

class FullPageTableChart extends StatelessWidget {
  final FullPageTableModel data;
  final String title;
  final int flexLeft = 1;
  final int flexRight = 2;
  final bool shimmer;

  const FullPageTableChart({Key key, this.data, this.title, this.shimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullPageGenericChart<SimpleRow>(
      map: data.map,
      title: title,
      flexLeft: flexLeft,
      totalRowBuilder: total,
      flexRight: flexRight,
      rowBuilder: listItem,
      shimmer: shimmer,
      measureRow: MeasureRow(
        leftFlex: flexLeft,
        rightFlex: flexRight,
        measure1: data.measure,
        measure2: data.measure1,
        measure3: data.measure2,
      ),
    );
  }

  Widget listItem(SimpleRow item) {
    return SimpleItem(
      flexRight: flexRight,
      flexLeft: flexLeft,
      data: item,
    );
  }

  Widget total(List<SimpleRow> items) {
    return HighlightedRow(
      flexRight: flexRight,
      flexLeft: flexLeft,
      rows: items,
    );
  }
}
