import 'location.dart';
import 'networking.dart';
import 'package:geolocator/geolocator.dart';

const apiKey = '327f47634cf4452dd0e22af893b566d5';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    var weatherModelData = await networkHelper.getData();
    return weatherModelData;
  }

  Future<dynamic> getLocationWeather() async {
    Position position = await MyLocation().determinePosition();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');

    var weatherModelData = await networkHelper.getData();
    return weatherModelData;
  }

  String? getWeatherIcon(int condition) {
    if (condition < 400) {
      return 'Drizzle';
    } else if (condition < 500) {
      return 'Rain';
    } else if (condition < 600) {
      return 'Snow';
    } else if (condition == 800) {
      return 'Clear sky';
    } else {
      return 'Clouds';
    }
  }

  String? getMessage(int temp) {
    if (temp > 28) {
      return 'temperature is high';
    } else if (temp > 20) {
      return 'temperature is medium';
    } else if (temp > 15) {
      return 'temperature is low';
    } else {
      return 'too cold';
    }
  }
}
