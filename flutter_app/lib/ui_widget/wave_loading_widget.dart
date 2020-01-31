import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WaveLoadingWidget extends StatefulWidget {
  final String text;

  final double fontSize;

  final Color backgroundColor;

  final Color foregroundColor;

  final Color waveColor;

  WaveLoadingWidget({
    @required this.text,
    @required this.fontSize,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.waveColor,
  }) {
    assert(text != null && text.length == 1);
    assert(fontSize != null && fontSize > 0);
  }

  @override
  _WaveLoadingWidgetState createState() => _WaveLoadingWidgetState(
        text: text,
        fontSize: fontSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        waveColor: waveColor,
      );
}

class _WaveLoadingWidgetState extends State<WaveLoadingWidget>
    with SingleTickerProviderStateMixin {
  final String text;

  final double fontSize;

  final Color backgroundColor;

  final Color foregroundColor;

  final Color waveColor;

  AnimationController controller;

  Animation<double> animation;

  _WaveLoadingWidgetState({
    @required this.text,
    @required this.fontSize,
    @required this.backgroundColor,
    @required this.foregroundColor,
    @required this.waveColor,
  });

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          print('動畫在開始後停止(或尚未開始)');
          break;
        case AnimationStatus.forward:
          print('動畫從頭到尾運行');
          break;
        case AnimationStatus.reverse:
          print('動畫反向播放');
          break;
        case AnimationStatus.completed:
          print('動畫在播放後停止');
          break;
      }
    });

    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WaveLoadingPainter(
        text: text,
        fontSize: fontSize,
        animatedValue: animation.value,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        waveColor: waveColor,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class WaveLoadingPainter extends CustomPainter {
  static final defaultColor = Colors.lightBlue;

  /// 畫筆實例
  final _paint = Paint();

  /// 圓形路徑
  final _circlePath = Path();

  /// 波浪路徑
  final _wavePath = Path();

  /// 要顯示的文字
  final String text;

  /// 字體大小
  final double fontSize;

  final Color backgroundColor;

  final Color foregroundColor;

  final Color waveColor;

  final double animatedValue;

  WaveLoadingPainter({
    this.text,
    this.fontSize,
    this.backgroundColor,
    this.foregroundColor,
    this.waveColor,
    this.animatedValue,
  }) {
    _paint
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..color = waveColor ?? defaultColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final side = min(size.width, size.height);
    final radius = side / 2.0;

    // 繪製 backgroundColor 文本
    _drawText(
      canvas: canvas,
      side: side,
      color: backgroundColor,
    );

    // 建構圓形路徑 circlePath
    _circlePath.reset();
    _circlePath.addArc(Rect.fromLTWH(0, 0, side, side), 0, 2 * pi);

    // 利用貝賽爾曲線繪製波浪線
    final waveWidth = side * 0.8;
    final waveHeight = side / 6;
    _wavePath.reset();
    _wavePath.moveTo((animatedValue - 1) * waveWidth, radius);
    for (double i = -waveWidth; i < side; i += waveWidth) {
      _wavePath.relativeQuadraticBezierTo(
          waveWidth / 4, -waveHeight, waveWidth / 2, 0);
      _wavePath.relativeQuadraticBezierTo(
          waveWidth / 4, waveHeight, waveWidth / 2, 0);
    }
    _wavePath.relativeLineTo(0, radius);
    _wavePath.lineTo(-waveWidth, side);
    _wavePath.close();

    // 取 _circlePath 和 _wavePath 的交集
    final combine =
        Path.combine(PathOperation.intersect, _circlePath, _wavePath);
    canvas.drawPath(combine, _paint);

    // 裁切畫布並繪製頂層文本
    canvas.clipPath(combine);
    _drawText(canvas: canvas, side: side, color: foregroundColor);
  }

  void _drawText({Canvas canvas, double side, Color color}) {
    final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontStyle: FontStyle.normal,
      fontSize: fontSize ?? 0,
    ))
      ..pushStyle(ui.TextStyle(color: color ?? defaultColor))
      ..addText(text);
    final paragraphConstraints = ui.ParagraphConstraints(width: fontSize ?? 0);
    final paragraph = paragraphBuilder.build()..layout(paragraphConstraints);
    canvas.drawParagraph(
      paragraph,
      Offset(
        (side - paragraph.width) / 2.0,
        (side - paragraph.height) / 2.0,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
