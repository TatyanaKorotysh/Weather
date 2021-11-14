import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/bloc/navigationBarBloc.dart';
import 'package:weather/events/NavigationBarEvents.dart';
import 'package:weather/pages/components/appBar.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  final _navigationBarBloc = NavigationBarBloc();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        _navigationBarBloc.navigationBarEventSink
            .add(RouteToTodayWeatherEvent());
        break;
      case 1:
        _navigationBarBloc.navigationBarEventSink
            .add(RouteToForecastWeatherEvent());
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _navigationBarBloc.navigationBarEventSink.add(RouteToTodayWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: _navigationBarBloc.navigationBarSink,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
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
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationBarBloc.dispose();
  }
}
