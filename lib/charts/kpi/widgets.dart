import 'configs.dart';

class Kuch extends StatelessWidget {
  final String number;
  final String title;

  const Kuch({Key key, this.number, this.title})
      : assert(number != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          number,
          style: textStyle_large1,
        ),
        Text(
          title,
          style: textStyle_caption,
        ),
      ],
    );
  }
}

class Kuch1 extends StatelessWidget {
  final String value;
  final String title;

  const Kuch1({Key key, this.value, this.title})
      : assert(value != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            value,
            style: textStyle_subOverlineLight,
          ),
          Text(
            title,
            style: textStyle_subOverlineRegular,
          ),
        ],
      ),
    );
  }
}

class DownTriangle extends CustomPainter {
  Color color;

  DownTriangle({this.color = color_primary});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()..color = color;
    Path path = Path();
    path.addPolygon([
      Offset(size.width, 0),
      Offset(size.width / 2, size.height),
      Offset(0, 0),
    ], true);
    canvas.drawPath(path, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class UpTriangle extends CustomPainter {
  Color color;

  UpTriangle({this.color = color_primary});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()..color = color;
    Path path = Path();
    path.addPolygon([
      Offset(size.width / 2, 0),
      Offset(size.width, size.height),
      Offset(0, size.height),
    ], true);
    canvas.drawPath(path, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
