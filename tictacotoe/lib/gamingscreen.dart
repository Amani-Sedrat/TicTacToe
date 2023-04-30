import 'package:flutter/material.dart';
import 'dart:math';

class TicTacToeScreen extends StatefulWidget {
  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class TicTacToeScreenState extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';

  @override
  void initState() {
    super.initState();
    resetBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5D5FEF),
              Color(0XFF843CE0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 36,
                ),
                Text(
                  'Tic',
                  style: TextStyle(fontSize: 50, color: Color(0xFFF9D967)),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Tac',
                  style: TextStyle(fontSize: 50, color: Color(0xFFE773FF)),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Toe",
                  style: TextStyle(fontSize: 50, color: Color(0XFF4FFAFF)),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'you play with an X',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            Text(
              'model plays with an O',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            SizedBox(height: 20.0),
            GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0XFF4FFAFF),
                      width: 2.0,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (board[index] == '' && winner == '') {
                        setState(() {
                          board[index] = currentPlayer;
                          if (checkWin()) {
                            winner = currentPlayer;
                          } else if (checkTie()) {
                            winner = 'Tie';
                          } else {
                            currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
                            if (currentPlayer == 'O') {
                              makeComputerMove();
                            }
                          }
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            winner != ''
                ? Text(
                    winner == 'Tie' ? 'It\'s a tie!' : 'Winner: $winner',
                    style: TextStyle(fontSize: 20.0),
                  )
                : SizedBox(),
            SizedBox(height: 30.0),
            Container(
              height: 50,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0XFF4FFAFF)),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 25, color: Color(0xFF5D5FEF)),
                ),
                onPressed: resetBoard,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
    });
  }

  bool checkWin() {
    // check rows
    for (int i = 0; i < 9; i += 3) {
      if (board[i] != '' &&
          board[i] == board[i + 1] &&
          board[i] == board[i + 2]) {
        return true;
      }
    }
    // chack columns
    for (int i = 0; i < 3; i++) {
      if (board[i] != '' &&
          board[i] == board[i + 3] &&
          board[i] == board[i + 6]) {
        return true;
      }
    }

    // check diagonals
    if (board[0] != '' && board[0] == board[4] && board[0] == board[8]) {
      return true;
    }
    if (board[2] != '' && board[2] == board[4] && board[2] == board[6]) {
      return true;
    }
    return false;
  }

  bool checkTie() {
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        return false;
      }
    }
    return true;
  }

  void makeComputerMove() {
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        availableMoves.add(i);
      }
    }
    if (availableMoves.isEmpty) {
      return;
    }
    int bestMove = availableMoves[0];
    int bestScore = -10000;
    for (int i = 0; i < availableMoves.length; i++) {
      int move = availableMoves[i];
      board[move] = 'O';
      int score = minimax(board, 0, false);
      board[move] = '';
      if (score > bestScore) {
        bestScore = score;
        bestMove = move;
      }
    }
    board[bestMove] = 'O';
    if (checkWin()) {
      winner = 'O';
    } else if (checkTie()) {
      winner = 'Tie';
    } else {
      currentPlayer = 'X';
    }
  }

  int minimax(List<String> board, int depth, bool isMaximizing) {
    if (checkWin()) {
      return isMaximizing ? -10 + depth : 10 - depth;
    } else if (checkTie()) {
      return 0;
    }
    int bestScore = isMaximizing ? -10000 : 10000;
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        availableMoves.add(i);
      }
    }
    for (int i = 0; i < availableMoves.length; i++) {
      int move = availableMoves[i];
      board[move] = isMaximizing ? 'O' : 'X';
      int score = minimax(board, depth + 1, !isMaximizing);
      board[move] = '';
      if (isMaximizing) {
        bestScore = max(bestScore, score);
      } else {
        bestScore = min(bestScore, score);
      }
    }
    return bestScore;
  }
}
