import 'package:flutter/material.dart';
import 'package:tictactoe/tileState.dart';

class BoardTile extends StatelessWidget {
  const BoardTile({
    Key? key,
    required this.dimension,
    required this.onPressed,
    required this.tileState
  }) : super(key: key);

  final double dimension;
  final VoidCallback onPressed;
  final TileState tileState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: TextButton(
        onPressed: onPressed,
        child: _widgetForTileState(),
      ),
    );
  }

  Widget _widgetForTileState(){
    Widget widget;

    switch(tileState){
      case TileState.EMPTY:
        {
          widget = Container();
        }
        break;
      case TileState.CROSS:
        {
          widget = Image.asset("images/x.png");
        }
        break;
      case TileState.CIRCLE:
        {
          widget = Image.asset("images/o.png");
        }
        break;
    }

    return widget;
  }

}
