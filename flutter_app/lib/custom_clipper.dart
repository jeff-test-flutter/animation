import 'dart:math';

import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final space = 25.0;
    return Rect.fromLTWH(space, space, size.width - space, size.height - space);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class StarClipper extends CustomClipper<Path> {
  final double radius;

  StarClipper({this.radius});

  @override
  Path getClip(Size size) {
    /// 五角星的角度
    final radian = _degree2Radian(36);

    /// 中間五邊形的半徑
    final radius_in = (radius * sin(radian / 2) / cos(radian));

    final path = Path();
    path.moveTo((radius * cos(radian / 2)), 0.0); // 多邊形的起點
    path.lineTo((radius * cos(radian / 2) + radius_in * sin(radian)),
        (radius - radius * sin(radian / 2)));
    path.lineTo(
        (radius * cos(radian / 2) * 2), (radius - radius * sin(radian / 2)));
    path.lineTo((radius * cos(radian / 2) + radius_in * cos(radian / 2)),
        (radius + radius_in * sin(radian / 2)));
    path.lineTo((radius * cos(radian / 2) + radius * sin(radian)),
        (radius + radius * cos(radian)));
    path.lineTo((radius * cos(radian / 2)), (radius + radius_in));
    path.lineTo((radius * cos(radian / 2) - radius * sin(radian)),
        (radius + radius * cos(radian)));
    path.lineTo((radius * cos(radian / 2) - radius_in * cos(radian / 2)),
        (radius + radius_in * sin(radian / 2)));
    path.lineTo(0.0, (radius - radius * sin(radian / 2)));
    path.lineTo((radius * cos(radian / 2) - radius_in * sin(radian)),
        (radius - radius * sin(radian / 2)));
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>
      radius != (oldClipper as StarClipper).radius;

  /// 將角度轉換為弧度
  double _degree2Radian(int degree) => (pi * degree) / 180;
}
