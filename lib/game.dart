import 'package:flutter/material.dart';
import 'package:tictao/winner_dialog.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;
  String winner = '';

  void _handleTap(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
        checkWinner();
      });

      if (winner != '') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return WinnerDialog(winner: winner);
          },
        );
      }
    }
  }


  void checkWinner() {
    // Rows
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] != '' &&
          board[i * 3] == board[i * 3 + 1] &&
          board[i * 3 + 1] == board[i * 3 + 2]) {
        setState(() {
          winner = board[i * 3];
        });
        return;
      }
    }

    // Columns
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6]) {
        setState(() {
          winner = board[i];
        });
        return;
      }
    }

    // Diagonals
    if (board[0] != '' &&
        board[0] == board[4] &&
        board[4] == board[8]) {
      setState(() {
        winner = board[0];
      });
      return;
    }

    if (board[2] != '' &&
        board[2] == board[4] &&
        board[4] == board[6]) {
      setState(() {
        winner = board[2];
      });
      return;
    }

    // Check for draw
    if (!board.contains('')) {
      setState(() {
        winner = 'draw';
      });
      return;
    }
  }
  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      xTurn = true;
      winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(

              shrinkWrap: true,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _handleTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(fontSize: 50.0),
                      ),
                    ),
                  ),
                );
              },
            ),
            if (winner != '')
              Column(
                children: [
                  Text(
                    winner == 'draw' ? "It's a draw!" : 'Player $winner wins!',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  TextButton(
                    onPressed: resetGame,
                    child: Text('Play Again'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
