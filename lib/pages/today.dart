import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:weather/bloc/share_weather_bloc.dart';
import 'package:weather/bloc/today_weather_bloc.dart';
import 'package:weather/entity/today/today.dart';
import 'package:weather/events/share_weather_events.dart';
import 'package:weather/events/today_weather_events.dart';
import 'package:weather/location/wind_direction.dart';
import 'package:weather/pages/components/app_bar.dart';
import 'package:weather/style/icons.dart';
import 'package:weather/style/text.dart';

class TodayWeather extends StatefulWidget {
  const TodayWeather({Key? key}) : super(key: key);

  @override
  _TodayWeatherState createState() => _TodayWeatherState();
}

class _TodayWeatherState extends State<TodayWeather> {
  final _todayWeatherBloc = TodayWeatherBloc();

  @override
  Widget build(BuildContext context) {
    _todayWeatherBloc.todayWeatherEventSink.add(UpdateTodayWeatherEvent());

    return StreamBuilder(
      stream: _todayWeatherBloc.todayWeatherStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          children: [
            const WeatherAppBar(title: "Today"),
            (snapshot.hasError)
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            child: const Text(
                              "Something is wrong. Please check your internet connection and location services.",
                              style: CustomTextStyle.textError,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              _todayWeatherBloc.todayWeatherEventSink
                                  .add(UpdateTodayWeatherEvent());
                            },
                            icon: const Icon(Icons.refresh_rounded),
                            iconSize: 50,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                  )
                : (snapshot.hasData)
                    ? TodayBody(data: snapshot.data as TodayWeatherApi)
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _todayWeatherBloc.dispose();
  }
}

class TodayBody extends StatelessWidget {
  final TodayWeatherApi data;

  const TodayBody({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (MediaQuery.of(context).orientation == Orientation.portrait)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainTodayWeather(data: data),
                DetailTodayWeather(data: data),
                ShareButton(data: data),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MainTodayWeather(data: data),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: DetailTodayWeather(data: data),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ShareButton(data: data),
                ),
              ],
            ),
    );
  }
}

class ShareButton extends StatelessWidget {
  final _shareWeatherBloc = ShareWeatherBloc();
  final TodayWeatherApi data;

  ShareButton({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _shareWeatherBloc.shareWeatherEventSink
            .add(SendWeatherAsTextEvent(shareData: data));
      },
      child: const Text(
        "Share",
        style: CustomTextStyle.textButton,
      ),
    );
  }
}

class DetailTodayWeather extends StatelessWidget {
  final TodayWeatherApi data;

  const DetailTodayWeather({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          indent: MediaQuery.of(context).size.width * 0.3,
          endIndent: MediaQuery.of(context).size.width * 0.3,
          color: Colors.grey[300],
          thickness: 1,
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DetailIcon(
              icon: FontAwesomeIcons.tint,
              data: "${data.main.humidity} %",
            ),
            DetailIcon(
              icon: FontAwesomeIcons.thermometerHalf,
              data: "${data.main.temp} °C",
            ),
            DetailIcon(
              icon: FontAwesomeIcons.snowflake,
              data: "${data.main.pressure} hPa",
            )
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailIcon(
              icon: FontAwesomeIcons.wind,
              data: "${data.wind.speed} km/h",
            ),
            DetailIcon(
              icon: FontAwesomeIcons.compass,
              data: windDirection(data.wind.deg),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        Divider(
          indent: MediaQuery.of(context).size.width * 0.3,
          endIndent: MediaQuery.of(context).size.width * 0.3,
          color: Colors.grey[300],
          thickness: 1,
        ),
      ],
    );
  }
}

class DetailIcon extends StatelessWidget {
  final IconData icon;
  final String data;

  const DetailIcon({
    Key? key,
    required this.icon,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Colors.amber,
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          data,
          style: CustomTextStyle.simpleText,
        )
      ],
    );
  }
}

class MainTodayWeather extends StatelessWidget {
  final TodayWeatherApi data;

  const MainTodayWeather({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 25, top: 10),
          child: Icon(
            CustomIcons.icons[data.weather[0].icon],
            color: Colors.amber,
            size: 100,
          ),
        ),
        Container(
          child: Text(
            "${data.name}, ${data.sys.country}",
            style: CustomTextStyle.title,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        Text(
          "${(data.main.temp).toInt()}°C | ${data.weather[0].main}",
          style: CustomTextStyle.bigText,
        ),
      ],
    );
  }
}
