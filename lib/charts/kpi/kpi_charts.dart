import 'configs.dart';
import 'models.dart';
import 'widgets.dart';

class TwoNumber extends StatelessWidget {
  final TwoNumberData data;

  const TwoNumber({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  factory TwoNumber.sample() {
    return TwoNumber(
      data: TwoNumberData.sample(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Kuch(
              number: data.number1,
              title: data.title1,
            ),
          ),
        ),
        Container(
          width: 0.2,
          color: color_secondary,
          margin: const EdgeInsets.all(8),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Kuch(
              number: data.number2,
              title: data.title2,
            ),
          ),
        )
      ],
    );
  }
}

class OneNumber extends StatelessWidget {
  final OneNumberData data;

  const OneNumber({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  factory OneNumber.sample() {
    return OneNumber(
      data: OneNumberData.sample(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        data.number.toString(),
        style: textStyle_large,
      ),
    );
  }
}

class KpiGraph extends StatelessWidget {
  final KpiGraphData data;

  const KpiGraph({Key key, @required this.data})
      : assert(data != null),
        super(key: key);

  factory KpiGraph.sample() {
    return KpiGraph(
      data: KpiGraphData.sample(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: CustomPaint(
                size: Size(16, 16),
                foregroundPainter: data.progress
                    ? UpTriangle(color: color_greenLight)
                    : DownTriangle(color: color_red),
              ),
            ),
            Text(
              data.value.toString(),
              style: textStyle_large,
            ),
            Text(
              data.unit,
              style: textStyle_captionNumber,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Kuch1(
              value: data.leftValue.toString(),
              title: data.leftTitle,
            ),
            Kuch1(
              value: data.rightValue.toString(),
              title: data.rightTitle,
            ),
          ],
        )
      ],
    );
  }
}
