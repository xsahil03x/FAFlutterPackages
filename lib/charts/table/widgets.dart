import 'package:fa_manager_flutter/config/widgets.dart';
import 'package:fa_manager_flutter/helpers/number_system.dart';
import 'package:swipedetector/swipedetector.dart';

import 'configs.dart';
import 'models.dart';

class TotalRow extends StatelessWidget {
  final int flexLeft, flexRight;
  final List<KuchRow> rows;

  KuchRow get row {
    double measure = 0;
    rows.forEach((a) {
      measure = measure + a.value;
    });

    return KuchRow(name: text_total, valueDisplay: NumberSystem.parse(measure));
  }

  const TotalRow({Key key, this.rows, this.flexLeft, this.flexRight})
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
                row.name,
                style: textStyle_titleRegular.copyWith(
                    color: color_textBlackMedium),
              ),
            ),
          ),
          Expanded(
            flex: flexRight,
            child: Center(
              child: Text(
                row.valueDisplay,
                style: textStyle_titleRegular,
              ),
            ),
          ),
        ],
      ),
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
        )
      ],
    );
  }
}

class Chart extends StatefulWidget {
  final TableModel data;
  final bool expanded;

  const Chart({Key key, this.data, this.expanded}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WidgetStateTableChart();
}

class WidgetStateTableChart extends State<Chart> {
  final int flexLeft = 1;
  final int flexRight = 2;
  int selected;
  int length;

  @override
  void initState() {
    super.initState();
    selected = widget.data.keys != null && widget.data.keys.length > 0 ? 0 : -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectedItem(
          title: selected == -1 ? '' : widget.data.keys[selected],
          increment: increment,
          isLeft: selected > 0,
          isRight: selected < widget.data.keys.length - 1,
          leftFlex: flexLeft,
          rightFlex: flexRight,
        ),
        ConditionalWidget(
          condition: selected == -1,
          childTrue: Container(),
          childFalse: TotalRow(
            flexLeft: flexLeft,
            flexRight: flexRight,
            rows: selected == -1
                ? []
                : widget.data.map[widget.data.keys[selected]],
          ),
        ),
        Expanded(
          child: SwipeDetector(
            swipeConfiguration: swipeConfiguration,
            onSwipeLeft: swipeLeft,
            onSwipeRight: swipeRight,
            child: ListView.builder(
                itemCount: selected == -1
                    ? 0
                    : widget.expanded ||
                            widget.data.map[widget.data.keys[selected]].length <
                                expansionThreshold
                        ? widget.data.map[widget.data.keys[selected]].length
                        : expansionThreshold,
                physics: widget.expanded
                    ? scrollPhysics
                    : NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SimpleItem(
                    flexLeft: flexLeft,
                    flexRight: flexRight,
                    data: widget.data.map[widget.data.keys[selected]][index],
                  );
                }),
          ),
        )
      ],
    );
  }

  void increment(bool incremented) {
    incremented ? swipeLeft() : swipeRight();
  }

  void swipeLeft() {
    setState(() {
      if (selected < widget.data.keys.length - 1) selected = selected + 1;
    });
  }

  void swipeRight() {
    setState(() {
      if (selected > 0) selected = selected - 1;
    });
  }
}

class SimpleItem extends StatelessWidget {
  final int flexLeft, flexRight;
  final KuchRow data;

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
            child: Center(
              child: Text(
                data.valueDisplay,
                style: textStyle_bodyRegular,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ChartExpanded extends StatelessWidget {
  final String title;
  final TableModel data;

  const ChartExpanded({Key key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        backgroundColor: color_primary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, appbarBarWidgetSpace, 8, 8),
        child: Chart(
          data: data,
          expanded: true,
        ),
      ),
    );
  }
}
