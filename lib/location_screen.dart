import 'package:flutter/material.dart';
import 'weather.dart';
import 'city_screen.dart';
import 'constant.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key, this.locationData}) : super(key: key);
  final locationData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationData);
  }

  WeatherModel weatherModel = WeatherModel();
  int? temperature;
  int? condition;
  String? cityName;
  String? weatherIcon;
  String? weatherMessage;
  void updateUI(dynamic weatherData) {
    setState(
      () {
        if (weatherData == Null) {
          temperature = 0;
          weatherIcon = 'Error';
          weatherMessage = 'Unable to get weather data.';
          cityName = '';
        }
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        weatherMessage = weatherModel.getMessage(temperature!);
        condition = weatherData['weather'][0]['id'];
        weatherIcon = weatherModel.getWeatherIcon(condition!);
        cityName = weatherData['name'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/image.jpg'), fit: BoxFit.cover),
        ),
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
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      color: Colors.pinkAccent,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return  const CityScreen();
                          },
                        ),
                      );
                      if (typedName != Null) {
                        var weatherData =
                            await weatherModel.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      color: Colors.pinkAccent,
                      size: 50.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text(
                      '$temperature°',
                      style: kTemperatureTextStyle,
                    ),
                    Text(
                      weatherIcon!,
                      style: kIconTextStyle,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName.',
                  style: kMessageTextStyle,
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
