module Board exposing (Board, GameState(..), Player(..), new, occupantOf, state)

import Avl.Set as Set exposing (Set)


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

member : a -> Set a -> Bool
member =
  Set.member (\a b -> compare (toString a) (toString b))

occupantOf : pos -> Board pos -> Maybe Player
occupantOf position board =
  if member position board.xs then
    Just X
  else if member position board.os then
    Just O
  else
    Nothing

state : Board pos -> GameState
state board =
  InProgress
