import 'package:know_your_weather/services/access_location.dart';
import 'package:know_your_weather/services/networking.dart';

const apiKey = 'e414973086edb01086b77abcacbe8d1a';
const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationAndDataByCityName({required var cityName}) async {
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric');
    var weather = await networkHelper.getData();
    return weather;
  }

  Future<dynamic> getLocationAndData() async {
    Location l = Location();
    await l.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherUrl?lat=${l.latitude}&lon=${l.longitude}&appid=$apiKey&units=metric');
    var weather = networkHelper.getData();
    print("Weather data:$weather");
    return weather;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Fucking hot day, It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring an 🧥 just in case';
    }
  }
}
