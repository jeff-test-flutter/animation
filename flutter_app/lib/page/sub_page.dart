import 'package:flutter/material.dart';
import 'package:flutter_app/ui_widget/wave_loading_widget.dart';

class SubPage extends StatefulWidget {
  @override
  _SubPageState createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.amber,
        child: Center(
          child: _buildWaveLoadingWidget(),
        ),
      ),
      onTap: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildWaveLoadingWidget() {
    return Container(
      width: 300,
      height: 300,
      child: WaveLoadingWidget(
        text: '喜',
        fontSize: 215,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        waveColor: Colors.lightBlue,
      ),
    );
  }
}
