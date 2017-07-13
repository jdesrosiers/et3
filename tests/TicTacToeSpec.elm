module TicTacToeSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)

import AnyTypeSet as Set exposing (Set)
import Fixture exposing (Position(..))
import TicTacToe exposing (GameState(..), Player(..))


suite : Test
suite =
  let
    boardFromMoves =
      \list ->
        List.foldl (\position board -> TicTacToe.play position board) Fixture.new list
  in
    describe "The TicTacToe module"
      [ describe "a new game"
          (let
            board = boardFromMoves []
          in
            [ test "it should be X's turn" <|
                \_ -> Expect.equal X board.player
            , test "it should not have an occupant at any position" <|
                \_ -> Expect.equal Nothing (TicTacToe.occupantOf A board)
            , test "it should have state 'InProgress'" <|
                \_ -> Expect.equal InProgress (TicTacToe.state board)
            , test "it should be able to play any position" <|
                \_ -> Expect.equal board.rules.positions (TicTacToe.allowedMoves board)
            ])
      , describe "a game in progress"
          (let
            board = boardFromMoves [ A, B ]
          in
            [ test "it should be X's turn" <|
                \_ -> Expect.equal X board.player
            , test "it should not have X at postion A" <|
                \_ -> Expect.equal (Just X) (TicTacToe.occupantOf A board)
            , test "it should have state 'InProgress'" <|
                \_ -> Expect.equal InProgress (TicTacToe.state board)
            , test "it should not be able to play position A" <|
                \_ -> Expect.equal False (Set.member A (TicTacToe.allowedMoves board))
            , test "it should not be able to play position B" <|
                \_ -> Expect.equal False (Set.member B (TicTacToe.allowedMoves board))
            , test "it should be able to play anything other than A and B" <|
                \_ -> Expect.equal (Set.fromList [ C, D ]) (TicTacToe.allowedMoves board)
            ])
      , describe "a game where X wins"
          [ test "it should have state 'XWins'" <|
              \_ -> Expect.equal XWins (TicTacToe.state (boardFromMoves [ A, C, B ]))
          ]
      , describe "a game where O wins"
          [ test "it should have state 'OWins'" <|
              \_ -> Expect.equal OWins (TicTacToe.state (boardFromMoves [ C, A, D, B ]))
          ]
      , describe "a game that is a draw"
          [ test "it should have state 'Draw'" <|
              \_ -> Expect.equal Draw (TicTacToe.state (boardFromMoves [ A, C, D, B ]))
          ]
      ]
