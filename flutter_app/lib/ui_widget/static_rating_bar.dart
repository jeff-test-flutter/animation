import 'dart:math' as Math show pi, sin, cos;

import 'package:flutter/material.dart';

const kMaxRate = 5.0;
const kNumberOfStarts = 5;
const kSpacing = 3.0;
const kSize = 50.0;

class StaticRatingBar extends StatelessWidget {
  /// 總星星數量
  final int count;

  /// 高亮星星數量
  final double rate;

  /// 星星尺寸
  final double size;

  final Color colorLight;

  final Color colorDark;

  StaticRatingBar({
    double rate,
    Color colorLight,
    Color colorDark,
    int count,
    this.size: kSize,
  })  : rate = rate ?? kMaxRate,
        count = count ?? kNumberOfStarts,
        colorDark = colorDark ?? Color(0xffeeeeee),
        colorLight = colorLight ?? Color(0xffFF962E);

  Widget _buildStar() => SizedBox(
        width: size * count,
        height: size,
        child: CustomPaint(
          painter: _PainterStars(
            size: size / 2,
            color: colorLight,
            style: PaintingStyle.fill,
            strokeWidth: 0.0,
          ),
        ),
      );

  Widget _buildHollowStar() => SizedBox(
        width: size * count,
        height: size,
        child: CustomPaint(
          painter: _PainterStars(
            size: size / 2,
            color: colorDark,
            style: PaintingStyle.fill,
            strokeWidth: 0.0,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          _buildHollowStar(),
          ClipRect(
            clipper: _RatingBarClipper(width: rate * size),
            child: _buildStar(),
          )
        ],
      );
}

class _RatingBarClipper extends CustomClipper<Rect> {
  final double width;

  _RatingBarClipper({@required this.width}) : assert(width != null);

  @override
  Rect getClip(Size size) => Rect.fromLTRB(0.0, 0.0, width, size.height);

  @override
  bool shouldReclip(_RatingBarClipper oldClipper) => width != oldClipper.width;
}

class _PainterStars extends CustomPainter {
  final double size;
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;

  _PainterStars({this.size, this.color, this.strokeWidth, this.style});

  /// 角度转弧度公式
  double _degree2Radian(int degree) => (Math.pi * degree / 180);

  Path _createStarPath(double radius, Path path) {
    final radian = _degree2Radian(36); // 36为五角星的角度
    final radius_in = (radius * Math.sin(radian / 2) / Math.cos(radian)) *
        1.1; // 中间五边形的半径,太正不是很好看，扩大一点点

    path.moveTo((radius * Math.cos(radian / 2)), 0.0); // 此点为多边形的起点
    path.lineTo((radius * Math.cos(radian / 2) + radius_in * Math.sin(radian)),
        (radius - radius * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) * 2),
        (radius - radius * Math.sin(radian / 2)));
    path.lineTo(
        (radius * Math.cos(radian / 2) + radius_in * Math.cos(radian / 2)),
        (radius + radius_in * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) + radius * Math.sin(radian)),
        (radius + radius * Math.cos(radian)));
    path.lineTo((radius * Math.cos(radian / 2)), (radius + radius_in));
    path.lineTo((radius * Math.cos(radian / 2) - radius * Math.sin(radian)),
        (radius + radius * Math.cos(radian)));
    path.lineTo(
        (radius * Math.cos(radian / 2) - radius_in * Math.cos(radian / 2)),
        (radius + radius_in * Math.sin(radian / 2)));
    path.lineTo(0.0, (radius - radius * Math.sin(radian / 2)));
    path.lineTo((radius * Math.cos(radian / 2) - radius_in * Math.sin(radian)),
        (radius - radius * Math.sin(radian / 2)));

    path.lineTo((radius * Math.cos(radian / 2)), 0.0);
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final offset = strokeWidth > 0 ? strokeWidth + 2 : 0.0;

    final paint = Paint();
    paint.strokeWidth = strokeWidth;
    paint.color = color;
    paint.style = style;

    Path path = Path();
    path = _createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = _createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = _createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = _createStarPath(this.size - offset, path);
    path = path.shift(new Offset(this.size * 2, 0.0));
    path = _createStarPath(this.size - offset, path);
    if (offset > 0) {
      path = path.shift(new Offset(offset, offset));
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PainterStars oldDelegate) =>
      oldDelegate.size != this.size;
}
