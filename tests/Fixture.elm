module Fixture exposing (Position(..), new)

import AnyTypeSet as Set exposing (Set)
import TicTacToe exposing (Board, Rules)


type Position =
  A | B | C | D

winStates : List (Set Position)
winStates =
  [ Set.fromList [ A, B ]
  , Set.fromList [ A, C ]
  ]

positions : Set Position
positions =
  Set.fromList [ A, B, C, D ]

new : Board Position
new =
  TicTacToe.new (Rules winStates positions)
