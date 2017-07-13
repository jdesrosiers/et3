module TicTacToeSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)

import AnyTypeSet as Set exposing (Set)
import TicTacToe exposing (GameState(..), Player(..))


type PositionFixture =
  Foo

suite : Test
suite =
  describe "The TicTacToe module"
    [ describe "a new board"
        [ test "it should be an empty board with X playing first" <|
            \_ ->
              let
                board = TicTacToe.new
              in
                Expect.equal True (board.player == X && Set.isEmpty board.xs && Set.isEmpty board.os)
        , test "it should not have an occupant at any position" <|
            \_ -> Expect.equal Nothing (TicTacToe.occupantOf Foo TicTacToe.new)
        , test "it should have state 'InProgress'" <|
            \_ -> Expect.equal InProgress (TicTacToe.state TicTacToe.new)
        , test "it should be able to play any position" <|
            \_ ->
              let
                subject = TicTacToe.play Foo TicTacToe.new
              in
                Expect.equal (Just X) (TicTacToe.occupantOf Foo subject)
        ]
    ]
