module Minimax exposing (getMove)

import AnyTypeSet as Set exposing (Set)
import TicTacToe exposing (Board, GameState(..), Player(..))


type alias Node pos =
  { position : Maybe pos
  , score : Int
  }

getMove : Board pos -> Maybe pos
getMove board =
  let
    node = minimax 6 board
  in
    node.position

minimax : Int -> Board pos -> Node pos
minimax depth board =
  case TicTacToe.state board of
    XWins ->
      --let
      --  d = Debug.log "state" XWins
      --in
        Node Nothing 10
    OWins ->
      --let
      --  d = Debug.log "state" OWins
      --in
        Node Nothing -10
    Draw ->
      --let
      --  d = Debug.log "state" Draw
      --in
        Node Nothing 0
    InProgress ->
      if depth <= 0 then
        Node Nothing 0
      else
        let
          allowedMoves = TicTacToe.allowedMoves board
          --d2 = Debug.log "allowedMoves" (Set.toList allowedMoves)
          --d1 = Debug.log "state" InProgress
          best =
            if board.player == X then
              Node Nothing -11
            else
              Node Nothing 11
        in
          bestNode depth board best (Set.toList allowedMoves)

compare : Player -> comparable -> comparable -> Bool
compare player =
  case player of
    X -> (>)
    O -> (<)

bestNode : Int -> Board pos -> Node pos -> List pos -> Node pos
bestNode depth board best positions =
  case positions of
    [] ->
      --let
      --  d = Debug.log "Choose" best
      --in
        best
    position :: tail ->
      let
        subject = TicTacToe.play position board |> minimax (depth - 1)
        --d = Debug.log "play" position
        newBest =
          if compare board.player subject.score best.score then
            Node (Just position) subject.score
          else
            best
      in
        bestNode depth board newBest tail
