import 'package:example/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:fa_flutter_packages/fa_flutter_packages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = getDummyBarData();
    var total = 0.0;
    list.sort((a, b) => b.score.compareTo(a.score));
    list.forEach((a) {
      total = total + a.score;
    });
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(children: [
        Container(
          height: 200,
          child: BarGraph(
            list: list,
            total: total,
            title: 'Test Bar Graph',
            totalDisplay: total.toString(),
            disableColor: true,
            animate: true,
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          child: PieChart(
            list: getGaugeSegmentData(),
            total: 3000.0,
            animate: true,
            truncateList: getGaugeSegmentData(),
            title: 'Test Pie Chart',
            action: 'MTD',
          ),
        ),
      ]),
    );
  }
}
