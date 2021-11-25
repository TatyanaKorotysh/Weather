import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/forecast_cubit.dart';

import 'package:weather/entity/forecast/forecast.dart';
import 'package:weather/pages/components/app_bar.dart';
import 'package:weather/style/icons.dart';
import 'package:weather/style/text.dart';

class Forecast extends StatefulWidget {
  const Forecast({Key? key}) : super(key: key);

  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    context.read<ForecastCubit>().getForecastData();

    return BlocBuilder<ForecastCubit, ForecastApi?>(
        builder: (context, forecastData) {
      return Column(children: [
        (forecastData == null)
            ? const WeatherAppBar(title: "Forecast")
            : WeatherAppBar(title: forecastData.city.name.toString()),
        (forecastData == null)
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ForecastBody(data: forecastData)
      ]);
    });
  }
}

class ForecastBody extends StatelessWidget {
  final ForecastApi data;

  const ForecastBody({
    Key? key,
    required this.data,
  }) : super(key: key);

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
                padding: const EdgeInsets.only(left: 15),
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
                  physics: const ClampingScrollPhysics(),
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
                        padding: const EdgeInsets.only(right: 25),
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
