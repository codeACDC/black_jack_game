import 'package:flutter/material.dart';
import 'package:black_jack_game/screens/black_jack_main_screen.dart';

void main() => runApp(const blackJack());

class blackJack extends StatelessWidget {
  const blackJack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primarySwatch: Colors.indigo),home: blackJackMainScreen());
  }
}
