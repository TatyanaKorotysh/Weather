import 'package:flutter/material.dart';
import 'package:weather/style/text.dart';

class WeatherAppBar extends StatelessWidget {
  final String title;

  WeatherAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: CustomTextStyle.title,
            ),
          ),
        ),
        PreferredSize(
          child: Container(
            color: Colors.blueAccent,
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0),
        ),
      ],
    );
  }
}
