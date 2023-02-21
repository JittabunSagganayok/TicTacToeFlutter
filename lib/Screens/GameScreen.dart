import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndexes = []; //เก็บช่องที่ชนะ แล้ว เปลี่ยนสีตอนชนะ

  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  String resultDeclaration = 'Start O turn'; //text ประกาศคนชนะ
  bool winnerFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // children: [
                  //   Text(
                  //     'Player O',
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       letterSpacing: 3,
                  //       fontSize: 28,
                  //     ),
                  //   ),
                  //   Text(
                  //     oScore.toString(),
                  //     style: TextStyle(
                  //       color: Colors.black,
                  //       letterSpacing: 3,
                  //       fontSize: 28,
                  //     ),
                  //   ),
                  // ],
                ),
                SizedBox(width: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Let's Play",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 3,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      // xScore.toString()
                      " ",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 3,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: Colors.red,
                        ),
                        color: matchedIndexes.contains(index)
                            ? Colors.blue //แบร้กกราวเมื่อชนะ
                            : Colors.white, //แบร้กกราวตอนเริ่มเล่น
                      ),
                      child: Center(
                        child: Text(displayXO[index],
                            style: TextStyle(
                              fontSize: 64,
                              color: matchedIndexes.contains(index)
                                  ? Colors.white //สี O , X เมื่อชนะ
                                  : Colors.blue, //สี O , X ตอนเริ่มเล่น
                            )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(resultDeclaration,
                      style: TextStyle(
                          color: Colors.black, letterSpacing: 3, fontSize: 28)),
                  SizedBox(height: 10),
                  _buildTimer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      print(winnerFound);
      if (winnerFound == false) {
        if (oTurn && displayXO[index] == '') {
          displayXO[index] = 'O';
          filledBoxes++;
        } else if (!oTurn && displayXO[index] == '') {
          displayXO[index] = 'X';
          filledBoxes++;
        }

        oTurn = !oTurn;
        if (oTurn == true) {
          resultDeclaration = "Start O turn";
        } else {
          resultDeclaration = "Start X turn";
        }

        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    // check 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 1, 2]);

        _updateScore(displayXO[0]);
        // _clearBoard();
      });
    }

    // check 2nd row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[3] + ' Wins!';
        matchedIndexes.addAll([3, 4, 5]);

        _updateScore(displayXO[3]);
      });
    }

    // check 3rd row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 7, 8]);

        _updateScore(displayXO[6]);
      });
    }

    // check 1st column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 3, 6]);

        _updateScore(displayXO[0]);
      });
    }

    // check 2nd column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[1] + ' Wins!';
        matchedIndexes.addAll([1, 4, 7]);

        _updateScore(displayXO[1]);
      });
    }

    // check 3rd column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[2] + ' Wins!';
        matchedIndexes.addAll([2, 5, 8]);

        _updateScore(displayXO[2]);
      });
    }

    // check diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[0] + ' Wins!';
        matchedIndexes.addAll([0, 4, 8]);

        _updateScore(displayXO[0]);
      });
    }

    // check diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ' + displayXO[6] + ' Wins!';
        matchedIndexes.addAll([6, 4, 2]);

        _updateScore(displayXO[6]);
      });
    }
    if (filledBoxes == 9 && winnerFound == false) {
      setState(() {
        resultDeclaration = 'Nobody Wins!';
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _clearBoard();
          });
        });
      });
    }
  }

  void _updateScore(String winner) {
    winnerFound = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (winner == 'O') {
        oScore++;
      } else if (winner == 'X') {
        xScore++;
      }
      _clearBoard();
    });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      resultDeclaration = 'Start O turn';
      matchedIndexes = [];
      oTurn = true;
      filledBoxes = 0;
      winnerFound = false;
    });
  }

  Widget _buildTimer() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: () {
        _clearBoard();
      },
      child: Text(
        "Clear",
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }
}
