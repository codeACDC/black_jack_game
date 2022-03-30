import 'package:flutter/material.dart';

class gridOfCards extends StatelessWidget {
  List<Image> somePlayerCards;
  bool isPlayer;

  gridOfCards(this.somePlayerCards, this.isPlayer, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: GridView.builder(
            itemCount: somePlayerCards.length,
            physics: isPlayer
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return somePlayerCards[index];
            }),
      ),
    );
  }
}
