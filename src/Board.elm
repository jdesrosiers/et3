module Board exposing (Board, GameState(..), Player(..), new, occupantOf, play, state)

import AnyTypeSet as Set exposing (Set)


type Player =
  X | O

type GameState =
  InProgress | XWins | OWins | Draw

type alias Board pos =
  { player : Player
  , xs : Set pos
  , os : Set pos
  }

new : Board pos
new = { player = X, xs = Set.empty, os = Set.empty }

occupantOf : pos -> Board pos -> Maybe Player
occupantOf position board =
  if Set.member position board.xs then
    Just X
  else if Set.member position board.os then
    Just O
  else
    Nothing

play : pos -> Board pos -> Board pos
play position board =
  case board.player of
    X -> { board | player = O, xs = Set.insert position board.xs }
    O -> { board | player = X, os = Set.insert position board.os }

state : Board pos -> GameState
state board =
  InProgress
