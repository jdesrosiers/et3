module Classic exposing (Position(..), new)

import AnyTypeSet as Set exposing (Set)
import TicTacToe exposing (Board, Rules)


type Position =
    TopLeft    | TopMiddle    | TopRight
  | MiddleLeft | Center       | MiddleRight
  | BottomLeft | BottomMiddle | BottomRight

winStates : List (Set Position)
winStates =
  -- rows
  [ Set.fromList [ TopLeft, TopMiddle, TopRight ]
  , Set.fromList [ MiddleLeft, Center, MiddleRight ]
  , Set.fromList [ BottomLeft, BottomMiddle, BottomRight ]

  -- columns
  , Set.fromList [ TopLeft, MiddleLeft, BottomLeft ]
  , Set.fromList [ TopMiddle, Center, BottomMiddle ]
  , Set.fromList [ TopRight, MiddleRight, BottomRight ]

  -- diagonals
  , Set.fromList [ TopLeft, Center, BottomRight ]
  , Set.fromList [ TopRight, Center, BottomLeft ]
  ]

positions : Set Position
positions =
  Set.fromList
    [ TopLeft, TopMiddle, TopRight
    , MiddleLeft, Center, MiddleRight
    , BottomLeft, BottomMiddle, BottomRight
    ]

new : Board Position
new =
  TicTacToe.new (Rules winStates positions)
