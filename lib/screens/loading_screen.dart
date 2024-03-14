import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:know_your_weather/screens/location_page.dart';
import 'package:know_your_weather/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationAndData();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationPage(weatherData: weatherData);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SpinKitCircle(color: Colors.white, size: 30.0),
      ),
    );
  }
}

// var temperature = jsonDecode(data)['main']['temp'];
// var cityName = jsonDecode(data)['name'];
// print('CityName:$cityName');
// print('Temperature:$temperature');
// print('Condition or id:$condition');
