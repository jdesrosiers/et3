module TicTacToe exposing
  (Board, GameState(..), Player(..), Rules
  , allowedMoves, new, occupantOf, play, state
  )

import AnyTypeSet as Set exposing (Set)


type Player =
  X | O

type GameState =
  InProgress | XWins | OWins | Draw

type alias Board pos =
  { player : Player
  , xs : Set pos
  , os : Set pos
  , rules : Rules pos
  }

type alias Rules pos =
  { winStates : List (Set pos)
  , positions : Set pos
  }

new : Rules pos -> Board pos
new rules =
  { player = X
  , xs = Set.empty
  , os = Set.empty
  , rules = rules
  }

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

allowedMoves : Board pos -> Set pos
allowedMoves board =
  Set.diff board.rules.positions (Set.union board.xs board.os)

state : Board pos -> GameState
state board =
  if List.any (\winState -> Set.subset winState board.xs) board.rules.winStates then
    XWins
  else if List.any (\winState -> Set.subset winState board.os) board.rules.winStates then
    OWins
  else if Set.isEmpty (allowedMoves board) then
    Draw
  else
    InProgress
