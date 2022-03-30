import 'dart:math';
import 'package:flutter/material.dart';
import 'package:black_jack_game/constants/constants.dart';
import 'package:black_jack_game/widgets/black_jack_buttons.dart';
import 'package:black_jack_game/widgets/cards_grid_view.dart';

class blackJackMainScreen extends StatefulWidget {
  const blackJackMainScreen({Key? key}) : super(key: key);

  @override
  State<blackJackMainScreen> createState() => _blackJackMainScreenState();
}

class _blackJackMainScreenState extends State<blackJackMainScreen> {
  Map<String, int> playingCards = {};
  List<Image> dealerCards = [];
  List<Image> playerCards = [];

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  void addCard() {
    if (playingCards.isNotEmpty) {
      Random random = Random();
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == cardKey);

      setState(() {
        playerCards.add(Image.asset(cardKey));
      });

      playerScore = playerScore + deckOfCards[cardKey]!;
    }
  }

  bool isGameStart = false;

  String? dealerFirstCard;
  String? dealerSecondCard;
  String? playerFirstCard;
  String? playerSecondCard;

  int dealerScore = 0;
  int playerScore = 0;

  void changeCards() {
    playingCards = {};
    playingCards.addAll(deckOfCards);

    setState(() {
      isGameStart = true;
    });
    playerCards = [];
    dealerCards = [];

    Random random = Random();

    String oneKeyCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == oneKeyCard);
    String twoKeyCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == twoKeyCard);
    String threeKeyCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == threeKeyCard);
    String fourKeyCard =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == fourKeyCard);

    dealerFirstCard = oneKeyCard;
    dealerSecondCard = twoKeyCard;
    playerFirstCard = threeKeyCard;
    playerSecondCard = fourKeyCard;

    dealerCards.add(Image.asset(dealerFirstCard!));
    dealerCards.add(Image.asset(dealerSecondCard!));

    playerCards.add(Image.asset(playerFirstCard!));
    playerCards.add(Image.asset(playerSecondCard!));

    playerScore =
        deckOfCards[playerFirstCard]! + deckOfCards[playerSecondCard]!;
    dealerScore =
        deckOfCards[dealerFirstCard]! + deckOfCards[dealerSecondCard]!;

    if (dealerScore <= 14) {
      String oneMoreCard =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == oneMoreCard);
      dealerCards.add(Image.asset(oneMoreCard));
      dealerScore = dealerScore + deckOfCards[oneMoreCard]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isGameStart == true
            ? SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Dealer cards
                      Column(
                        children: [
                          Text(
                            'Dealer score: $dealerScore',
                            style: TextStyle(
                                color: dealerScore > 21
                                    ? Colors.red
                                    : Colors.green[900]),
                          ),
                          const SizedBox(height: 11),
                          gridOfCards(dealerCards, false),
                        ],
                      ),

                      //Player cards
                      Column(
                        children: [
                          Text(
                            'Player score: $playerScore',
                            style: TextStyle(
                                color: playerScore > 21
                                    ? Colors.red
                                    : Colors.green[900]),
                          ),
                          const SizedBox(height: 11),
                          gridOfCards(playerCards, true),
                        ],
                      ),
                      /*
                      * Two buttons:
                      * 1)Another card
                      * 2)Next round
                      */
                      IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            blackJackButton(function: addCard, label: 'Another card', isNextButton: true,
                                someScore: playerScore, someDealerScore: dealerScore),
                            const SizedBox(height: 11),
                            blackJackButton(function: changeCards, label:'Next round'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: blackJackButton(function: changeCards, label: 'Start game'),
              ));
  }
}
