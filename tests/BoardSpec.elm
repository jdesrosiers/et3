module BoardSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)

import Avl.Set as Set exposing (Set)

import Board exposing (GameState(..), Player(..))


type PositionFixture =
  Foo

suite : Test
suite =
  describe "The Board module"
    [ describe "a new board"
        [ test "it should be an empty board with X playing first" <|
            \_ ->
              let
                board = Board.new
              in
                Expect.equal True (board.player == X && Set.isEmpty board.xs && Set.isEmpty board.os)
        , test "it should not have an occupant at any position" <|
            \_ -> Expect.equal Nothing (Board.occupantOf Foo Board.new)
        , test "it should have state 'InProgress'" <|
            \_ -> Expect.equal InProgress (Board.state Board.new)
        ]
    ]
