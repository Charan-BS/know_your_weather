import 'package:flutter/material.dart';
import 'package:know_your_weather/screens/search_city.dart';
import 'package:know_your_weather/utilities/constants.dart';
import 'package:know_your_weather/services/weather.dart';

WeatherModel weatherModel = WeatherModel();

class LocationPage extends StatefulWidget {
  LocationPage({this.weatherData});
  final weatherData;
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  int temperature = 0;
  String weatherIcon = '';
  String msg = '';
  String city = '';
  void initState() {
    super.initState();
    print('success again');
    updateUI(widget.weatherData);
  }

  void updateUI(var weatherData) {
    setState(() {
      print(weatherData);
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '❌';
        msg = 'Error while trying to get data';
        city = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      msg = weatherModel.getMessage(temperature);
      city = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/Wallpaper.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationAndData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                      color: Colors.yellow,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      var weatherData = await weatherModel
                          .getLocationAndDataByCityName(cityName: cityName);
                      if (weatherData != null) {
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 40.0,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100.00),
                child: Text(
                  "$msg in $city!",
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
