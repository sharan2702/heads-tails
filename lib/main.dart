import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(HeadsTailsGame());
}

class HeadsTailsGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int playerScore = 0;
  int computerScore = 0;
  int rounds = 0;
  List<bool?> playerResults = List.filled(5, null);
  List<bool?> computerResults = List.filled(5, null);

  void playGame(String choice) {
    if (rounds >= 5) return;

    bool isHeads = Random().nextBool();
    bool playerWon = (choice == "Heads" && isHeads) || (choice == "Tails" && !isHeads);

    setState(() {
      playerResults[rounds] = playerWon;
      computerResults[rounds] = !playerWon;
      if (playerWon) {
        playerScore++;
      } else {
        computerScore++;
      }
      rounds++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Heads or Tails Game')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My Score", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: playerResults.map((result) => _buildCircle(result)).toList(),
            ),
            SizedBox(height: 20),
            Text("Computer Score", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: computerResults.map((result) => _buildCircle(result)).toList(),
            ),
            SizedBox(height: 40),
            if (rounds < 5)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton("Heads"),
                  SizedBox(width: 20),
                  _buildButton("Tails"),
                ],
              )
            else
              Text(
                _getResultText(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(bool? won) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: won == null ? Colors.grey : (won ? Colors.green : Colors.red),
      ),
    );
  }

  Widget _buildButton(String choice) {
    return ElevatedButton(
      onPressed: () => playGame(choice),
      child: Text("Choose $choice"),
    );
  }

  String _getResultText() {
    if (playerScore > computerScore) {
      return "You beat the computer by ${playerScore - computerScore} point${playerScore - computerScore > 1 ? 's' : ''}";
    } else if (playerScore < computerScore) {
      return "Computer wins by ${computerScore - playerScore} point${computerScore - playerScore > 1 ? 's' : ''}";
    } else {
      return "It's a tie!";
    }
  }
}
