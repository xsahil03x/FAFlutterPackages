import 'package:fa_manager_flutter/helpers/number_system.dart';
import 'package:swipedetector/swipedetector.dart';

import 'configs.dart';
import 'models.dart';

class MeasureTile extends StatelessWidget {
  final Measure measure;

  const MeasureTile({Key key, this.measure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              measure.name,
              style: textStyle_caption,
            ),
          ),
          decoration: BoxDecoration(
              color: color_secondaryLight,
              borderRadius: BorderRadius.all(Radius.circular(16))),
        ),
        Text(
          measure.unit,
          style: textStyle_captionNumber,
        ),
      ],
    );
  }
}

class MeasureRow extends StatelessWidget {
  final Measure measure1;
  final Measure measure2;
  final Measure measure3;
  final int leftFlex;
  final int rightFlex;

  const MeasureRow(
      {Key key,
      this.measure1,
      this.measure2,
      this.measure3,
      this.leftFlex,
      this.rightFlex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
          flex: leftFlex,
        ),
        Expanded(
          flex: rightFlex,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: MeasureTile(
                  measure: measure1,
                ),
              ),
              Expanded(
                flex: 1,
                child: MeasureTile(
                  measure: measure2,
                ),
              ),
              Expanded(
                flex: 1,
                child: MeasureTile(
                  measure: measure3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SelectedItem extends StatelessWidget {
  final Increment increment;
  final bool isRight, isLeft;
  final String title;
  final int leftFlex;
  final int rightFlex;

  const SelectedItem({
    Key key,
    this.increment,
    this.isRight,
    this.isLeft,
    this.title,
    this.leftFlex,
    this.rightFlex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
          flex: leftFlex,
        ),
        Expanded(
          flex: rightFlex,
          child: ShimmerWrapper(
            shimmer: TableInheritedWidget.of(context).shimmer,
            child: Container(
              height: 22,
              decoration: BoxDecoration(
                  color: color_grey_extra,
                  borderRadius: new BorderRadius.circular(11)),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Opacity(
                    opacity: isLeft ? 1 : 0,
                    child: GestureDetector(
                      onTap: () {
                        increment(false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                        child: Icon(
                          icNavigateBefore,
                          color: color_primary,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: textStyle_bodyLight.copyWith(
                      color: color_primaryDark,
                    ),
                  ),
                  Opacity(
                    opacity: isRight ? 1 : 0,
                    child: GestureDetector(
                      onTap: () {
                        increment(true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                        child: Icon(
                          icChevron,
                          color: color_primaryDark,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HighlightedRow extends StatelessWidget {
  final List<SimpleRow> rows;
  final int flexLeft;
  final int flexRight;
  final bool shimmer;

  const HighlightedRow(
      {Key key, this.rows, this.flexLeft, this.flexRight, this.shimmer})
      : super(key: key);

  SimpleRow get row {
    double measure = 0;
    double measure1 = 0;
    double measure2 = 0;
    rows.forEach((a) {
      measure = measure + a.measure;
      measure1 = measure1 + a.measure1;
      measure2 = measure2 + a.measure2;
    });
    return SimpleRow(
        text_total,
        measure,
        measure1,
        measure2,
        NumberSystem.parse(measure),
        NumberSystem.parse(measure1),
        NumberSystem.parse(measure2));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flexLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: ShimmerWrapper(
              shimmer: shimmer,
              child: Text(
                text_total,
                style: textStyle_titleRegular.copyWith(
                    color: color_textBlackMedium),
              ),
            ),
          ),
        ),
        Expanded(
            flex: flexRight,
            child: Row(
              children: [
                CenterExpanded(
                  child: Text(
                    row.measureDisplay,
                    style: textStyle_titleRegular,
                  ),
                ),
                CenterExpanded(
                  child: Text(
                    row.measure1Display,
                    style: textStyle_titleRegular,
                  ),
                ),
                CenterExpanded(
                  child: Text(
                    row.measure2Display,
                    style: textStyle_titleRegular,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class SimpleItem extends StatelessWidget {
  final int flexLeft, flexRight;
  final SimpleRow data;

  const SimpleItem({Key key, this.flexLeft, this.flexRight, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Row(
        children: [
          Expanded(
            flex: flexLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                data.name,
                style: textStyle_bodyLight,
              ),
            ),
          ),
          Expanded(
            flex: flexRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CenterExpanded(
                  child: Text(
                    data.measureDisplay,
                    style: textStyle_bodyRegular,
                  ),
                ),
                CenterExpanded(
                  child: Text(
                    data.measure1Display,
                    style: textStyle_bodyRegular,
                  ),
                ),
                CenterExpanded(
                  child: Text(
                    data.measure2Display,
                    style: textStyle_bodyRegular,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TableChart<T> extends StatefulWidget {
  final Map<String, List<T>> map;
  final bool expanded;
  final Widget measureRow;
  final TotalRowBuilder<T> totalRowBuilder;
  final RowBuilder<T> rowBuilder;
  final int flexLeft;
  final int flexRight;

  List<String> get keys => map.keys.toList();

  const TableChart(
      {Key key,
      this.map,
      this.expanded = false,
      this.measureRow,
      this.totalRowBuilder,
      this.rowBuilder,
      this.flexLeft,
      this.flexRight})
      : super(key: key);

  @override
  State<TableChart> createState() => WidgetStateTableChart<T>();
}

class WidgetStateTableChart<T> extends State<TableChart<T>> {
  int selected;
  int length;

  @override
  void initState() {
    super.initState();
    selected = widget.keys != null && widget.keys.length > 0 ? 0 : -1;
  }

  void increment(bool incremented) {
    if (incremented)
      swipeLeft();
    else
      swipeRight();
  }

  void swipeLeft() {
    setState(() {
      if (selected < widget.keys.length - 1) selected = selected + 1;
    });
  }

  void swipeRight() {
    setState(() {
      if (selected > 0) selected = selected - 1;
    });
  }

  Widget totalRowBuilder() {
    return widget.totalRowBuilder(widget.map[widget.keys[selected]]);
  }

  bool noData() {
    return selected == -1 || widget.map.length == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 4,
        ),
        SelectedItem(
          title: widget.keys != null && widget.keys.length > 0
              ? widget.keys[selected]
              : '',
          increment: increment,
          isLeft: selected > 0,
          isRight: selected < widget.keys.length - 1,
          leftFlex: widget.flexLeft,
          rightFlex: widget.flexRight,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
          child: widget.measureRow,
        ),
        noData() ? Container() : totalRowBuilder(),
        Expanded(
          child: SwipeDetector(
            onSwipeLeft: swipeLeft,
            onSwipeRight: swipeRight,
            child: ListView.builder(
                itemCount: noData()
                    ? 0
                    : widget.expanded ||
                            widget.map[widget.keys[selected]].length < 4
                        ? widget.map[widget.keys[selected]].length
                        : 4,
                physics: widget.expanded
                    ? scrollPhysics
                    : NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return widget
                      .rowBuilder(widget.map[widget.keys[selected]][index]);
                }),
          ),
        )
      ],
    );
  }
}

class TableChartExpanded<T> extends StatelessWidget {
  final String title;
  final Map<String, List<T>> map;
  final Widget measureRow;
  final TotalRowBuilder<T> totalRow;
  final RowBuilder<T> rowBuilder;
  final int flexLeft;
  final int flexRight;
  final bool shimmer;

  const TableChartExpanded(
      {Key key,
      this.title,
      this.map,
      this.measureRow,
      this.totalRow,
      this.rowBuilder,
      this.flexLeft,
      this.flexRight,
      this.shimmer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBack(
      title: title,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
        child: TableInheritedWidget(
          shimmer: shimmer,
          child: TableChart<T>(
            map: map,
            expanded: true,
            measureRow: measureRow,
            totalRowBuilder: totalRow,
            rowBuilder: rowBuilder,
            flexRight: flexRight,
            flexLeft: flexLeft,
          ),
        ),
      ),
    );
  }
}

class TableInheritedWidget extends InheritedWidget {
  final bool shimmer;

  const TableInheritedWidget({this.shimmer, child}) : super(child: child);

  @override
  bool updateShouldNotify(TableInheritedWidget oldWidget) {
    return shimmer != oldWidget.shimmer;
  }

  static TableInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(TableInheritedWidget);
  }
}
