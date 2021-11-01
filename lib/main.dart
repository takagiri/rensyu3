import 'dart:html';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rensyu3/memory/memory1.dart';
import 'package:rensyu3/memory/memory2.dart';
import 'package:rensyu3/memory/memory3.dart';
import 'package:rensyu3/memory/memory4.dart';
import 'package:rensyu3/memory/memory5.dart';
import 'package:rensyu3/memory/memory6.dart';
import 'package:rensyu3/menu.dart';

const kColorPurple = Color(0xFF8337EC);
const kColorPink = Color(0xFFFF006F);
const kColorIndicatorBegin = kColorPink;
const kColorIndicatorEnd = kColorPurple;
const kColorTitle = Color(0xFF616161);
const kColorText = Color(0xFF9E9E9E);
const kElevation = 4.0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class _BatteryLevelIndicatorPainter extends CustomPainter {
  final double percentage; // バッテリーレベルの割合
  final double textCircleRadius; // 内側に表示される白丸の半径

  _BatteryLevelIndicatorPainter({
    required this.percentage,
    required this.textCircleRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 1; i < (360 * percentage); i += 5) {
      final per = i / 360.0;
      // 割合（0~1.0）からグラデーション色に変換
      final color = ColorTween(
        begin: kColorIndicatorBegin,
        end: kColorIndicatorEnd,
      ).lerp(per)!;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      final spaceLen = 16; // 円とゲージ間の長さ
      final lineLen = 24; // ゲージの長さ
      final angle = (2 * pi * per) - (pi / 2); // 0時方向から開始するため-90度ずらす

      // 円の中心座標
      final offset0 = Offset(size.width * 0.5, size.height * 0.5);
      // 線の内側部分の座標
      final offset1 = offset0.translate(
        (textCircleRadius + spaceLen) * cos(angle),
        (textCircleRadius + spaceLen) * sin(angle),
      );
      // 線の外側部分の座標
      final offset2 = offset1.translate(
        lineLen * cos(angle),
        lineLen * sin(angle),
      );

      canvas.drawLine(offset1, offset2, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BatteryLevelIndicator extends StatefulWidget {
  @override
  _BatteryLevelIndicatorState createState() => _BatteryLevelIndicatorState();
}

class _BatteryLevelIndicatorState extends State<BatteryLevelIndicator> {
  double percentage = 100;

  final size = 164.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: CustomPaint(
              painter: _BatteryLevelIndicatorPainter(
                percentage: percentage,
                textCircleRadius: size * 0.5,
              ),
              child: Container(
                padding: const EdgeInsets.all(64),
                child: Material(
                  color: Colors.white,
                  elevation: kElevation,
                  borderRadius: BorderRadius.circular(size * 0.5),
                  child: Container(
                    width: size,
                    height: size,
                    child: Center(
                      child: Text(
                        '$percentage',
                        style: TextStyle(color: kColorPink, fontSize: 48),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  percentage += 10;
                });
              },
              child: Icon(Icons.add),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  percentage -= 10;
                });
              },
              child: Icon(
                Icons.remove,
              ),
            ),
          ),
        ],
      ),
      //   child: CustomPaint(
      //   painter: _BatteryLevelIndicatorPainter(
      //     percentage: percentage,
      //     textCircleRadius: size * 0.5,
      //   ),
      //   child: Container(
      //     padding: const EdgeInsets.all(64),
      //     child: Material(
      //       color: Colors.white,
      //       elevation: kElevation,
      //       borderRadius: BorderRadius.circular(size * 0.5),
      //       child: Container(
      //         width: size,
      //         height: size,
      //         child: Center(
      //           child: Text(
      //             '${percentage * 100}%',
      //             style: TextStyle(color: kColorPink, fontSize: 48),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモリ1です'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Menu();
                }),
              );
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Memory1();
                            }));
                          },
                          child: Text('メモリ1'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Memory2();
                            }));
                          },
                          child: Text('メモリ2'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Memory3();
                            }));
                          },
                          child: Text('メモリ3'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Memory4();
                            }));
                          },
                          child: Text('メモリ4'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Memory5();
                            }));
                          },
                          child: Text('メモリ5'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Memory6();
                            }));
                          },
                          child: Text('メモリ6'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('左'),
                      FloatingActionButton(
                        onPressed: null,
                        child: Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        onPressed: null,
                        child: Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        onPressed: null,
                        child: Icon(Icons.volume_up),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('右'),
                      FloatingActionButton(
                        onPressed: () {
                          //_BatteryLevelIndicatorPainter.percentage += 0.1;
                        },
                        child: Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        onPressed: null,
                        child: Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        onPressed: null,
                        child: Icon(Icons.volume_up),
                      ),
                    ],
                  ),
                ),
                BatteryLevelIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
