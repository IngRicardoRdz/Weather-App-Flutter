import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

// * Providers
import 'package:wheater_app/src/providers/providers.dart';

// * Models
import 'package:wheater_app/src/models/weatherList.model.dart';

class WheaterDays extends StatelessWidget {
  const WheaterDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context);

    final weatherList = weather.dataWeatherList;

    return SizedBox(
        width: double.infinity,
        height: 250,
        child: _WeatherList(weatherList: weatherList));
  }
}

class _WeatherList extends StatelessWidget {
  const _WeatherList({
    Key? key,
    required this.weatherList,
  }) : super(key: key);

  final WeatherModelList? weatherList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: weatherList?.list.length ?? 0,
      itemBuilder: (_, int index) => FadeInUp(
        child: Container(
          width: 200,
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(25),
          ),
          child: _WeatherData(weatherList?.list[index]),
        ),
      ),
    );
  }
}

class _WeatherData extends StatelessWidget {
  const _WeatherData(
    this.list, {
    Key? key,
  }) : super(key: key);

  final ListElement? list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Image(list: list),
        _MinTemp(list: list),
        const SizedBox(height: 5),
        _MaxTemp(list: list),
        const SizedBox(height: 5),
        _Text(list: list),
        const SizedBox(height: 5),
        _Date(list: list),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListElement? list;

  @override
  Widget build(BuildContext context) {
    return Image.network(
        'http://openweathermap.org/img/wn/${list!.weather[0].icon}@2x.png',
        fit: BoxFit.cover);
  }
}

class _MaxTemp extends StatelessWidget {
  const _MaxTemp({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListElement? list;

  @override
  Widget build(BuildContext context) {
    return Text('Max: ${list!.main.tempMax} °C',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}

class _MinTemp extends StatelessWidget {
  const _MinTemp({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListElement? list;

  @override
  Widget build(BuildContext context) {
    return Text('Min: ${list!.main.tempMin} °C',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListElement? list;

  @override
  Widget build(BuildContext context) {
    return Text(list!.weather[0].description.toUpperCase(),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}

class _Date extends StatelessWidget {
  const _Date({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListElement? list;

  @override
  Widget build(BuildContext context) {
    return Text('${list?.dtTxt}',
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}
