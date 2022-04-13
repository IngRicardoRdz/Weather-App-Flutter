import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

// * Providers
import 'package:wheater_app/src/providers/providers.dart';

class WeatherData extends StatelessWidget {
  const WeatherData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const _Data()));
  }
}

class _Data extends StatelessWidget {
  const _Data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BounceInDown(
            delay: const Duration(milliseconds: 1000), child: const _Image()),
        ElasticInLeft(child: const _Text()),
        const SizedBox(height: 25.0),
        SlideInRight(child: const _City()),
        const SizedBox(height: 25.0),
        FadeInUp(child: const _Temperature()),
        const SizedBox(height: 20.0),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerweather = Provider.of<WeatherProvider>(context).dataWeather;

    return Image.network(
        'http://openweathermap.org/img/wn/${providerweather?.weather[0].icon}@2x.png',
        fit: BoxFit.cover);
  }
}

class _Text extends StatelessWidget {
  const _Text({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerweather = Provider.of<WeatherProvider>(context).dataWeather;

    return Text(
        '${providerweather?.weather[0].description.toString().toUpperCase()}',
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}

class _City extends StatelessWidget {
  const _City({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerweather = Provider.of<WeatherProvider>(context).dataWeather;

    return Text('${providerweather?.sys.country}, ${providerweather?.name}',
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}

class _Temperature extends StatelessWidget {
  const _Temperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerweather = Provider.of<WeatherProvider>(context).dataWeather;

    return Text('${providerweather?.main.temp} °C',
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}
