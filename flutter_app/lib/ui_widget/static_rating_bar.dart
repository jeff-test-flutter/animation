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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
