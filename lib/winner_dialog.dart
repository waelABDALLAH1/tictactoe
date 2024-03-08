import 'package:flutter/material.dart';

class WinnerDialog extends StatelessWidget {
  final String winner;

  WinnerDialog({required this.winner});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Game Over'),
      content: Text(winner == 'draw' ? "It's a draw!" : 'Player $winner wins!'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
