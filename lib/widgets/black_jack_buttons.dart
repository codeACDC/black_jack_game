import 'package:flutter/material.dart';

class blackJackButton extends StatelessWidget {
  Function() function;
  final String label;
  bool isNextButton;
  int someScore, someDealerScore;

  blackJackButton({
    required this.function,
    required this.label,
    this.someDealerScore = 20,
    this.someScore = 20,
    this.isNextButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: isNextButton && (someScore >= 21 || someDealerScore >= 21)
          ? null
          : function,
      child: Text(label),
      color: Colors.green[900],
    );
  }
}
