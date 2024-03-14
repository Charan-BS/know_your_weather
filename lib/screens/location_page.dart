import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:know_your_weather/screens/loading_screen.dart';
import 'package:know_your_weather/screens/search_city.dart';
import 'package:know_your_weather/utilities/constants.dart';
import 'package:know_your_weather/services/weather.dart';
import 'package:lottie/lottie.dart';

WeatherModel weatherModel = WeatherModel();

class LocationPage extends StatefulWidget {
  final dynamic weatherData;
  const LocationPage({required this.weatherData, super.key});
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  int temperature = 0;
  String weatherIcon = '';
  String msg = '';
  String city = '';
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void showLoading() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      isLoading = false; // Hide loading indicator
    });
    return;
  }

  void updateUI(var weatherData) {
    setState(() {
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          if (isLoading) ...[
            const SpinKitFadingCircle(
              color: Colors.redAccent,
              size: 40.0,
            ),
          ],
          TextButton(
            onPressed: () async {
              var cityName = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const CityScreen();
              }));
              showLoading();
              var weatherData = await weatherModel.getLocationAndDataByCityName(
                  cityName: cityName);
              if (weatherData != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.greenAccent,
                    content: Text(
                      'Updated successfully',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
                updateUI(weatherData);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'City not found',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            child: const Row(
              children: [
                Text(
                  "Search",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
        leading: TextButton(
          onPressed: () async {
            var weatherData = await weatherModel.getLocationAndData();
            updateUI(weatherData);
          },
          child: const Icon(
            Icons.near_me,
            size: 30.0,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/Wallpaper.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text('$temperature°', style: kTempTextStyle),
                    Text(weatherIcon, style: kConditionTextStyle),
                  ],
                ),
              ),
              temperature > 25
                  ? Lottie.asset("images/2.json", height: 300, width: 300)
                  : Lottie.asset("images/1.json", height: 300, width: 300),
              Padding(
                padding: const EdgeInsets.only(bottom: 80.00),
                child: Text(
                  "$msg in $city!",
                  style: kMessageTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
