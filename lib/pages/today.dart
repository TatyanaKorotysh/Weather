import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/bloc/shareWeatherBloc.dart';
import 'package:weather/bloc/todayWeatherBloc.dart';
import 'package:weather/entity/today/today.dart';
import 'package:weather/events/shareWeatherEvents.dart';
import 'package:weather/events/todayWeatherEvents.dart';
import 'package:weather/location/windDirection.dart';
import 'package:weather/pages/components/appBar.dart';
import 'package:weather/style/icons.dart';
import 'package:weather/style/text.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final _todayWeatherBloc = TodayWeatherBloc();

  @override
  Widget build(BuildContext context) {
    _todayWeatherBloc.todayWeatherEventSink.add(UpdateTodayWeatherEvent());

    return StreamBuilder(
      stream: _todayWeatherBloc.todayWeatherStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          children: [
            WeatherAppBar(title: "Today"),
            (snapshot.hasError)
                ? Expanded(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          snapshot.error.toString(),
                          style: CustomTextStyle.textError,
                        ),
                      ),
                    ),
                  )
                : (snapshot.hasData)
                    ? TodayBody(data: snapshot.data)
                    : Expanded(
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

  TodayBody({required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainTodayWeather(data: data),
          DetailTodayWeather(data: data),
          ShareButton(data: data),
        ],
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  final _shareWeatherBloc = ShareWeatherBloc();
  final TodayWeatherApi data;

  ShareButton({required this.data});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _shareWeatherBloc.shareWeatherEventSink
            .add(SendWeatherAsTextEvent(shareData: data));
      },
      child: Text(
        "Share",
        style: CustomTextStyle.textButton,
      ),
    );
  }
}

class DetailTodayWeather extends StatelessWidget {
  final TodayWeatherApi data;

  DetailTodayWeather({required this.data});

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
        Padding(padding: EdgeInsets.only(top: 20)),
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
        Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DetailIcon(
              icon: FontAwesomeIcons.wind,
              data: "${data.wind.speed} km/h",
            ),
            DetailIcon(
              icon: FontAwesomeIcons.compass,
              data: "${windDirection(data.wind.deg)}",
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
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

  DetailIcon({required this.icon, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Colors.amber,
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
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

  MainTodayWeather({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(right: 25),
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
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        Text(
          "${(data.main.temp).toInt()}°C | ${data.weather[0].main}",
          style: CustomTextStyle.bigText,
        ),
      ],
    );
  }
}
