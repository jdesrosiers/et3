module MinimaxSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)

import AnyTypeSet as Set exposing (Set)
import Classic exposing (Position(..))
import Minimax
import TicTacToe exposing (Board, GameState(..), Player(..))


suite : Test
suite =
  describe "The Minimax module"
    [ describe "getMove"
        [ test "it should choose TopMiddle (X wins)" <|
            \_ ->
              let
                board =
                  fromList X
                    [ x, n, x
                    , o, o, n
                    , x, o, n
                    ]
              in
                Expect.equal (Just TopMiddle) (Minimax.getMove board)
        , test "It should choose MiddleRight (O wins)" <|
            \_ ->
              let
                board =
                  fromList O
                    [ x, n, x
                    , o, o, n
                    , x, o, x
                    ]
              in
                Expect.equal (Just MiddleRight) (Minimax.getMove board)
        , test "It should choose TopMiddle (block O from winning)" <|
            \_ ->
              let
                board =
                  fromList X
                    [ x, n, n
                    , o, o, x
                    , x, o, n
                    ]
              in
                Expect.equal (Just TopMiddle) (Minimax.getMove board)
        , test "It should choose TopMiddle (block X from winning)" <|
            \_ ->
              let
                board =
                  fromList O
                    [ x, n, x
                    , n, o, x
                    , o, x, o
                    ]
              in
                Expect.equal (Just TopMiddle) (Minimax.getMove board)
        ]
    ]

positions =
  [ TopLeft, TopMiddle, TopRight
  , MiddleLeft, Center, MiddleRight
  , BottomLeft, BottomMiddle, BottomRight
  ]

fromList : Player -> List (Maybe Player) -> Board Position
fromList player boardState =
  let
    new = Classic.new
    legend = List.map2 (,) positions boardState
    xs =
      legend
        |> List.filter (\(position, player) -> player == Just X)
        |> List.map (\(position, player) -> position)
    os =
      legend
        |> List.filter (\(position, player) -> player == Just O)
        |> List.map (\(position, player) -> position)
  in
    { new
    | player = player
    , xs = Set.fromList xs
    , os = Set.fromList os
    }

x = Just X
o = Just O
n = Nothing
