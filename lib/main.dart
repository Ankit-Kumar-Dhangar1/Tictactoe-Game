import 'package:flutter/material.dart';

void main() => runApp(const TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  
  const TicTacToeGame({super.key});

  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> _board = [];
  bool _isPlayerX = false;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.filled(3, ''));
    _isPlayerX = true;
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _isPlayerX ? 'X' : 'O';
        _checkWin();
        _isPlayerX = !_isPlayerX;
      });
    }
  }

  void _checkWin() {
    // Check rows, columns, and diagonals for a win
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] &&
          _board[i][1] == _board[i][2] &&
          _board[i][0] != '') {
        _gameOver = true;
        _showResult(_board[i][0]);
        return;
      }
      if (_board[0][i] == _board[1][i] &&
          _board[1][i] == _board[2][i] &&
          _board[0][i] != '') {
        _gameOver = true;
        _showResult(_board[0][i]);
        return;
      }
    }

    if (_board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] &&
        _board[0][0] != '') {
      _gameOver = true;
      _showResult(_board[0][0]);
      return;
    }

    if (_board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0] &&
        _board[0][2] != '') {
      _gameOver = true;
      _showResult(_board[0][2]);
      return;
    }

    // Check for a draw
    bool isBoardFull = true;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          isBoardFull = false;
          break;
        }
      }
    }
    if (isBoardFull && !_gameOver) {
      _gameOver = true;
      _showResult('Draw');
    }
  }

  void _showResult(String winner) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Game Over'),
        content: winner == 'Draw'
            ? const Text('It\'s a draw!')
            : Text('Winner: $winner'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _initializeBoard();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Developer contact'),
        content: const Text("Ankit Kumar"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                _showAlertDialog();
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      color: Colors.lightGreen,
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: const TextStyle(
                              fontSize: 48.0, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              _gameOver
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _initializeBoard();
                        });
                      },
                      child: const Text('Play Again'),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
