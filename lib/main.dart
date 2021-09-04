import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;

  // 1st player is O
  List<String> matrix = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
              'XO Game'
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(40),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue)),
                      child: Center(
                        child: Text(
                          matrix[index],
                          style: TextStyle(color: Colors.black, fontSize: 35),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && matrix[index] == '') {
        matrix[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && matrix[index] == '') {
        matrix[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (matrix[0] == matrix[1] &&
        matrix[0] == matrix[2] &&
        matrix[0] != '') {
      gameResult(matrix[0]);
    }
    if (matrix[3] == matrix[4] &&
        matrix[3] == matrix[5] &&
        matrix[3] != '') {
      gameResult(matrix[3]);
    }
    if (matrix[6] == matrix[7] &&
        matrix[6] == matrix[8] &&
        matrix[6] != '') {
      gameResult(matrix[6]);
    }

    // Checking Column
    if (matrix[0] == matrix[3] &&
        matrix[0] == matrix[6] &&
        matrix[0] != '') {
      gameResult(matrix[0]);
    }
    if (matrix[1] == matrix[4] &&
        matrix[1] == matrix[7] &&
        matrix[1] != '') {
      gameResult(matrix[1]);
    }
    if (matrix[2] == matrix[5] &&
        matrix[2] == matrix[8] &&
        matrix[2] != '') {
      gameResult(matrix[2]);
    }

    // Checking Diagonal
    if (matrix[0] == matrix[4] &&
        matrix[0] == matrix[8] &&
        matrix[0] != '') {
      gameResult(matrix[0]);
    }
    if (matrix[2] == matrix[4] &&
        matrix[2] == matrix[6] &&
        matrix[2] != '') {
      gameResult(matrix[2]);
    } else if (filledBoxes == 9) {
      gameResult('Complete');
    }
  }

  void gameResult(String winner) {
    if(winner == 'Complete'){
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Complete Without Winner"),
              actions: [
                FlatButton(
                  child: Text("Play Again"),
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
    else {
      _clearBoard();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
                title: Text("\" " + winner + " \" is Winner!!!")
            );
          });
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        matrix[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
