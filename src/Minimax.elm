module Minimax exposing (getMove)

import AnyTypeSet as Set exposing (Set)
import TicTacToe exposing (Board, GameState(..), Player(..))


maxDepth : Int
maxDepth = 6

-- For the purposes of this algorithm, anything greater that the max score (10) is effectively infinity
infinity : Int
infinity = 11

winScore : Int
winScore = 10

drawScore : Int
drawScore = 0

type alias Node pos =
  { position : Maybe pos
  , score : Int
  }

getMove : Board pos -> Maybe pos
getMove board =
  let
    node = minimax maxDepth -infinity infinity board
  in
    node.position

minimax : Int -> Int -> Int -> Board pos -> Node pos
minimax depth alpha beta board =
  case TicTacToe.state board of
    XWins -> Node Nothing winScore
    OWins -> Node Nothing -winScore
    Draw -> Node Nothing drawScore
    InProgress ->
      if depth <= 0 then
        Node Nothing drawScore
      else
        let
          allowedMoves = TicTacToe.allowedMoves board
          best =
            if board.player == X then
              Node Nothing -infinity
            else
              Node Nothing infinity
        in
          bestNode depth alpha beta board best (Set.toList allowedMoves)

bestNode : Int -> Int -> Int -> Board pos -> Node pos -> List pos -> Node pos
bestNode depth alpha beta board best positions =
  case positions of
    [] -> best
    position :: tail ->
      let
        subject = TicTacToe.play position board |> minimax (depth - 1) alpha beta
        node = Node (Just position) subject.score
        (newBest, newAlpha, newBeta) = chooseNode board.player alpha beta best node
      in
        if newBeta <= newAlpha then
          newBest -- cut-off
        else
          bestNode depth newAlpha newBeta board newBest tail

chooseNode : Player -> Int -> Int -> Node pos -> Node pos -> (Node pos, Int, Int)
chooseNode player alpha beta best node =
  case player of
    X ->
      let
        result = nodeMax best node
      in
        (result, max alpha result.score, beta)
    O ->
      let
        result = nodeMin best node
      in
        (result, alpha, min beta result.score)

nodeMin : Node pos -> Node pos -> Node pos
nodeMin a b =
  if b.score < a.score then b else a

nodeMax : Node pos -> Node pos -> Node pos
nodeMax a b =
  if b.score > a.score then b else a
