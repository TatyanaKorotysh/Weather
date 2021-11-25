import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/bloc/navigation_cubit.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<NavigationCubit>().getTodayWeatherPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, Widget>(
        builder: (context, page) => page,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2, color: Colors.grey.shade300),
          ),
        ),
        child: BottomNavigationBar(
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.sun),
                label: 'Today',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.cloudMoon),
                label: 'Forecast',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blueAccent,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              switch (index) {
                case 0:
                  context.read<NavigationCubit>().getTodayWeatherPage();
                  break;
                case 1:
                  context.read<NavigationCubit>().getForecastPage();
                  break;
              }
            }),
      ),
    );
  }
}
