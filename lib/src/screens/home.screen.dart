import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// * Providers
import 'package:wheater_app/src/providers/providers.dart';

// * Widgets
import 'package:wheater_app/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerweather = Provider.of<WeatherProvider>(context);

    return (!providerweather.isLoading) ? const _HomeBody() : const _Loading();
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Background(),
          SingleChildScrollView(
              physics: BouncingScrollPhysics(), child: _WeatherColum()),
          MyAppBar(),
        ],
      ),
    );
  }
}

class _WeatherColum extends StatelessWidget {
  const _WeatherColum({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      WeatherData(),
      SizedBox(height: 20),
      WheaterDays(),
    ]);
  }
}

class _Loading extends StatelessWidget {
  const _Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Background(),
        Center(child: CircularProgressIndicator())
      ],
    );
  }
}
