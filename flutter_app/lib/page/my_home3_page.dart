import 'package:flutter/material.dart';
import 'package:flutter_app/custom_clipper.dart';

class MyHome3Page extends StatefulWidget {
  @override
  _MyHome3PageState createState() => _MyHome3PageState();
}

class _MyHome3PageState extends State<MyHome3Page> {
  Widget get _contentWidget => SizedBox(
        width: 150,
        height: 150,
        child: Image.network(
          'http://www.yezhou.me/images/flutter/tangyixin.jpg',
          fit: BoxFit.cover,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _buildRow1LeftWidget(),
                Container(
                  width: 10,
                ),
                _buildRow1RightWidget(),
              ],
            ),
            Container(
              height: 10,
            ),
            Row(
              children: <Widget>[
                _buildRow2LeftWidget(),
                Container(
                  width: 10,
                ),
                _buildRow2RightWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow1LeftWidget() => ClipOval(child: _contentWidget);

  Widget _buildRow1RightWidget() => ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _contentWidget,
      );

  Widget _buildRow2LeftWidget() => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.3),
        ),
        child: ClipRect(
          clipper: MyClipper(),
          child: _contentWidget,
        ),
      );

  Widget _buildRow2RightWidget() => ClipPath(
        clipper: StarClipper(radius: 80.0),
        child: _contentWidget,
      );
}
