import 'package:flutter/material.dart';
import 'package:weather/bloc/forecastBloc.dart';
import 'package:weather/entity/forecast/forecast.dart';
import 'package:weather/events/forecastEvents.dart';
import 'package:weather/pages/components/appBar.dart';
import 'package:intl/intl.dart';
import 'package:weather/style/icons.dart';
import 'package:weather/style/text.dart';

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
          return Column(
            children: [
              (snapshot.hasData)
                  ? WeatherAppBar(title: snapshot.data.city.name)
                  : WeatherAppBar(title: "Forecast"),
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
                      ? ForecastBody(data: snapshot.data)
                      : Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
            ],
          );
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

class ForecastBody extends StatelessWidget {
  final ForecastApi data;

  ForecastBody({required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: data.list.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[300],
            thickness: 1,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          String key = data.list.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15),
                height: 40,
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  (index == 0) ? "TODAY" : key.toUpperCase(),
                  style: CustomTextStyle.title,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey.shade300),
                  ),
                ),
              ),
              ListView.separated(
                  itemCount: data.list[key]!.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: MediaQuery.of(context).size.width * 0.25,
                      color: Colors.grey[300],
                      thickness: 1,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(right: 25),
                        child: Icon(
                          CustomIcons
                              .icons[data.list[key]![index].weather[0].icon],
                          color: Colors.amber,
                          size: 35,
                        ),
                      ),
                      title: Text(
                        DateFormat('HH:mm')
                            .format(data.list[key]![index].dtTxt),
                        style: CustomTextStyle.title,
                      ),
                      subtitle: Text(
                        data.list[key]![index].weather[0].main,
                        style: CustomTextStyle.simpleText,
                      ),
                      trailing: Text(
                        "${data.list[key]![index].main.temp.toInt()}°",
                        style: CustomTextStyle.largeText,
                      ),
                    );
                  }),
            ],
          );
        },
      ),
    );
  }
}
