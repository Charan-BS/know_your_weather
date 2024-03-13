import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:know_your_weather/screens/locationPage.dart';
import 'package:flutter_spinkit/src/circle.dart';
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
    print("method exectuted");
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationAndData();
    print("Print statement:$weatherData");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationPage(weatherData: weatherData);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: SpinKitCircle(
          color: Colors.yellow,
          size: 50.0,
        ),
      ),
    );
  }
}

// var temperature = jsonDecode(data)['main']['temp'];
// var cityName = jsonDecode(data)['name'];
// print('CityName:$cityName');
// print('Temperature:$temperature');
// print('Condition or id:$condition');
