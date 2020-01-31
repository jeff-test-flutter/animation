// 參考資料： https://juejin.im/post/5dfccde76fb9a0165d74e98b
// -> 參考MyHome1Page

// 參考資料： https://juejin.im/post/5ceb6179f265da1bc23f55d0
// -> 參考MyHome2Page

// 參考資料： http://www.appblog.cn/2019/01/10/Flutter%E4%B8%AD%E7%9A%84%E5%89%AA%E8%A3%81/
// 參考資料： https://segmentfault.com/a/1190000015149101
// -> 參考MyHome3Page

import 'package:flutter/material.dart';
import 'package:flutter_app/page/my_home1_page.dart';
import 'package:flutter_app/page/my_home2_page.dart';
import 'package:flutter_app/page/my_home3_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myHome1Page = MyHome1Page();
    final myHome2Page = MyHome2Page();
    final myHome3Page = MyHome3Page();
    return MaterialApp(home: myHome3Page);
  }
}
