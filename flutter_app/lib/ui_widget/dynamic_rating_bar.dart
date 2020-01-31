import 'dart:math' as Math show pi, sin, cos;

import 'package:flutter/material.dart';

const kMaxRate = 5.0;
const kNumberOfStarts = 5;
const kSpacing = 3.0;
const kSize = 50.0;

class DynamicRatingBar extends StatefulWidget {
  /// 回调
  final ValueChanged<int> onChange;

  /// 大小， 默认 50
  final double size;

  /// 值 1-5
  final int value;

  /// 数量 5 个默认
  final int count;

  /// 高亮
  final Color colorLight;

  /// 底色
  final Color colorDark;

  /// 如果有值，那么就是空心的
  final double strokeWidth;

  /// 越大，五角星越圆
  final double radiusRatio;

  DynamicRatingBar({
    this.onChange,
    this.value,
    this.size: kSize,
    this.count: kNumberOfStarts,
    this.strokeWidth,
    this.radiusRatio: 1.1,
    Color colorDark,
    Color colorLight,
  })  : colorDark = colorDark ?? Color(0xffDADBDF),
        colorLight = colorLight ?? Color(0xffFF962E);

  @override
  State<StatefulWidget> createState() => _DynamicRatingBarState();
}

class _DynamicRatingBarState extends State<DynamicRatingBar> {
  int _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  Widget _buildItem(int index, double size, count) {
    final selected = _value != null && _value > index;

    final stroke = widget.strokeWidth != null && widget.strokeWidth > 0;

    return new GestureDetector(
      onTap: () {
        if (widget.onChange != null) {
          widget.onChange(index + 1);
        }
        setState(() => _value = index + 1);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _PainterStar(
            radiusRatio: widget.radiusRatio,
            size: size / 2,
            color: selected ? widget.colorLight : widget.colorDark,
            style:
                !selected && stroke ? PaintingStyle.stroke : PaintingStyle.fill,
            strokeWidth: !selected && stroke ? widget.strokeWidth : 0.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final count = widget.count;

    List<Widget> list = [];
    for (int i = 0; i < count; ++i) {
      list.add(_buildItem(i, size, count));
    }

    return Row(children: list);
  }
}

class _PainterStar extends CustomPainter {
  final double size;
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;
  final double radiusRatio;

  _PainterStar({
    this.size,
    this.color,
    this.strokeWidth,
    this.style,
    this.radiusRatio,
  });

  /// 角度转弧度公式
  double _degree2Radian(int degree) => (Math.pi * degree / 180);

  Path _createStarPath({double radius, Path path}) {
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
    Paint paint = new Paint();
    paint.strokeWidth = strokeWidth;
    paint.color = color;
    paint.style = style;
    Path path = new Path();
    double offset = strokeWidth > 0 ? strokeWidth + 2 : 0.0;
    path = _createStarPath(
      radius: this.size - offset,
      path: path,
    );

    if (offset > 0) {
      path = path.shift(new Offset(offset, offset));
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_PainterStar oldDelegate) =>
      oldDelegate.size != this.size ||
      oldDelegate.color != this.color ||
      oldDelegate.strokeWidth != this.strokeWidth;
}
