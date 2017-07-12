module Board exposing (Board, GameState(..), Player(..), Position(..), new, occupantOf, state)

import Avl.Set as Set exposing (Set)


type Player =
  X | O

type Position =
    TopLeft    | TopMiddle    | TopRight
  | MiddleLeft | Center       | MiddleRight
  | BottomLeft | BottomMiddle | BottomRight

type GameState =
  InProgress | XWins | OWins | Draw

type alias Board =
  { player : Player
  , xs : Set Position
  , os : Set Position
  }

new : Board
new = { player = X, xs = Set.empty, os = Set.empty }

member : a -> Set a -> Bool
member =
  Set.member (\a b -> compare (toString a) (toString b))

occupantOf : Position -> Board -> Maybe Player
occupantOf position board =
  if member position board.xs then
    Just X
  else if member position board.os then
    Just O
  else
    Nothing

state : Board -> GameState
state board =
  InProgress
