import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// * Providers
import 'package:wheater_app/src/providers/providers.dart';

// * Screens
import 'package:wheater_app/src/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // * My Providers
      providers: [
        ChangeNotifierProvider(
            create: (_) => GeolocationProvider(), lazy: false),
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Whater App',
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
