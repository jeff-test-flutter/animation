import 'dart:math';

import 'package:flutter/material.dart';

class MyHome1Page extends StatefulWidget {
  @override
  _MyHome1PageState createState() => _MyHome1PageState();
}

// 如果你有幾個 Animation Controller 情況下，你想有不同的 Ticker ，只需要將 SingleTickerProviderStateMixin 替換為 TickerProviderStateMixin 。
class _MyHome1PageState extends State<MyHome1Page>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final milliseconds = 3850;
    _controller = AnimationController(
      duration: Duration(milliseconds: milliseconds),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {});
    });
    // 計數器開始計數
    _controller
        .forward()
        .orCancel; // 由於畫面可能會意外停止(譬如關閉螢幕)，加上 orCancel 可以保證在 _controller 釋放之前，如果 Ticker 取消了，將不會導致異常
    // 計數器開始反向計數
    Future.delayed(Duration(milliseconds: milliseconds + 550), () {
      _controller.reverse().orCancel;
    });
    // 停止動畫
    Future.delayed(Duration(milliseconds: milliseconds + 1550), () {
      _controller.stop();
    });
    // 將 value 重置為 LowerBound
    Future.delayed(Duration(milliseconds: milliseconds + 2550), () {
      _controller.reset();
    });
    // 將 value 改變為目標值
    Future.delayed(Duration(milliseconds: milliseconds + 3550), () {
      _controller
          .animateTo(0.3, duration: Duration(milliseconds: 500))
          .orCancel;
    });
    // 開始以正向運行動畫，並在動畫完成後重新啓動動畫
    Future.delayed(Duration(milliseconds: milliseconds + 5000), () {
      _controller.repeat().orCancel;
    });
    Future.delayed(Duration(milliseconds: milliseconds + 9000), () {
      _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用 controller 的參數配置(線性變化)
    final percent = (_controller.value * 100.0).round();
    // 自訂的參數配置(線性變化)
    final animate1 = Tween(begin: 0.0, end: pi / 2).animate(_controller);
    // 自訂的參數配置(非線性變化)
    final animate2 = Tween(begin: 0.0, end: pi / 2).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
      reverseCurve: Curves.easeInOut,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text('MyHome1Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${animate2.value}'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
