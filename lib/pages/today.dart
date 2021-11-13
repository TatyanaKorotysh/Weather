import 'package:flutter/material.dart';
import 'package:weather/bloc/todayWeatherBloc.dart';
import 'package:weather/events/todayWeatherEvents.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final _todayWeatherBloc = TodayWeatherBloc();

  @override
  Widget build(BuildContext context) {
    _todayWeatherBloc.todayWeatherEventSink.add(UpdateTodayWeatherEvent());

    return Center(
      child: StreamBuilder(
        stream: _todayWeatherBloc.todayWeatherSink,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${snapshot.data.clouds.all}',
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _todayWeatherBloc.dispose();
  }
}
