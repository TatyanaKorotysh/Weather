import 'package:flutter/material.dart';
import 'package:weather/bloc/forecastBloc.dart';
import 'package:weather/events/forecastEvents.dart';

class Forecast extends StatefulWidget {
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  final _forecastBloc = ForecastBloc();

  @override
  Widget build(BuildContext context) {
    _forecastBloc.forecastEventSink.add(UpdateForecastEvent());

    return Center(
      child: StreamBuilder(
        stream: _forecastBloc.forecastSink,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${snapshot.data.list}',
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
    _forecastBloc.dispose();
  }
}
