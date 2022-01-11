import 'package:flutter/material.dart';
import 'package:tictactoe/boardTile.dart';
import 'package:tictactoe/tileState.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _boardState = List.filled(9, TileState.EMPTY);
  var _currentState = TileState.CROSS;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
              Image.asset("images/board.png"),
              _boardTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _boardTile(){
    return Builder(builder: (context){
      final boardDimension = MediaQuery.of(context).size.width;
      final tileDimension = boardDimension/3;

      return SizedBox(
        width: boardDimension,
        height: boardDimension,
        child: Column(
          children: chunk(_boardState, 3).asMap().entries.map((entry) {
            final chunkIndex = entry.key;
            final tileStateChunk = entry.value;

            return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry) {
              final innerIndex = innerEntry.key;
              final tileState = innerEntry.value;
              final tileIndex =(chunkIndex * 3 ) + innerIndex;

              return BoardTile(
                tileState: tileState,
                dimension: tileDimension,
                onPressed: () => _updateTileStateForIndex(tileIndex),
              );
            }).toList(),
            );
          }).toList()
        ),
      );
    });
  }

  void _updateTileStateForIndex (int selectedIndex){
    if(_boardState[selectedIndex] == TileState.EMPTY){
      setState(() {
        _boardState[selectedIndex] = _currentState;
        _currentState = _currentState == TileState.CROSS
            ? TileState.CIRCLE
            : TileState.CROSS;
      });

      final winner = _findWinner();
      if(winner != null ){
        print("Winner is : $winner");
      }
    }
  }

  TileState _findWinner() {
    TileState Function(int, int, int) winnerForMatch = (a, b, c) {
      if (_boardState[a] != TileState.EMPTY) {
        if ((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])) {
          return _boardState[a];
        }
      }
      return null;
    };

    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
    ];

    TileState winner;
    for (int i = 0; i < checks.length; i++) {
      if (checks[i] != null) {
        winner = checks[i];
        break;
      }
    }
    return winner;
  }
}
