import 'package:flutter/material.dart';
import 'package:flutter_app/route_builder.dart';
import 'package:flutter_app/page/sub_page.dart';

class MyHome2Page extends StatefulWidget {
  @override
  _MyHome2PageState createState() => _MyHome2PageState();
}

class _MyHome2PageState extends State<MyHome2Page>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward().orCancel;
  }

  @override
  Widget build(BuildContext context) {
    /// 螢幕寬
    final screenWidth = MediaQuery.of(context).size.width;

    /// 螢幕高
    final screenHeight = MediaQuery.of(context).size.height;

    Offset offset1;
    Offset offset2;

    final Animation<Offset> moveCenterToTop = Tween(
      begin: Offset(0, 0),
      end: Offset(0, -screenHeight / 2 + 60),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.5, curve: Curves.linear),
    ));

    final Animation<Offset> moveLeftToCenter = Tween(
      begin: Offset(-screenWidth / 2, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.2, curve: Curves.linear),
    ));

    final disappear = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.5, 1.0, curve: Curves.linear),
    ));
    disappear.addStatusListener((status) {
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

    offset1 = moveLeftToCenter.value;
    offset2 = moveCenterToTop.value;

    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MyHome2Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.translate(
                offset: offset1,
                child: Transform.translate(
                  offset: offset2,
                  child: Opacity(
                    opacity: disappear.value,
                    child: Text('9487'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: _onTap,
    );
  }

  void _onTap() {
//    final route = SlideRouteBuilder(SubPage());
//    final route = ScaleRouteBuilder(SubPage());
//    final route = RotationRouteBuilder(SubPage());
//    final route = SizeRouteBuilder(SubPage());
//    final route = FadeRouteBuilder(SubPage());
//    final route = EnterExitRouteBuilder(exitPage: widget, enterPage: SubPage());
    final route = ScaleRotateRouteBuilder(SubPage());
    Navigator.of(context).push(route);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
