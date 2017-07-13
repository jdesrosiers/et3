module TicTacToeUISpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)
import Test.Html.Selector exposing (class, id)
import Test.Html.Query as Query

import Html.Attributes

import Board exposing (GameState(..), Player(..))
import TicTacToeUI exposing (Msg(..))


type PositionFixture =
  Foo | Bar

suite : Test
suite =
  describe "The TicTacToeUI module"
    [ describe "heading"
        [ test "it should indicate that it is X's turn" <|
            \_ ->
              let
                model = TicTacToeUI.new
              in
                Expect.equal "Player X's Turn" (TicTacToeUI.heading model)
        , test "it should indicate it is O's turn" <|
            \_ ->
              let
                model = TicTacToeUI.play Foo TicTacToeUI.new
              in
                Expect.equal "Player O's Turn" (TicTacToeUI.heading model)
        ]
    , describe "board"
        [ test "it should have classes 'board', 'Human', and any other attributes passed in" <|
            \_ ->
              let
                model = TicTacToeUI.new
              in
                TicTacToeUI.board model [ Html.Attributes.class "foo" ] []
                  |> Query.fromHtml
                  |> Query.has [ id "board", class "Human", class "foo" ]
        , test "it should have class 'InProgress'" <|
            \_ ->
              let
                model = TicTacToeUI.new
              in
                TicTacToeUI.board model [ Html.Attributes.class "foo" ] []
                  |> Query.fromHtml
                  |> Query.has [ class "InProgress" ]
        ]
    , describe "cell"
        [ test "it should have classes 'cell' and any other attributes passed in" <|
            \_ ->
              let
                model = TicTacToeUI.new
              in
                TicTacToeUI.cell model Foo [ Html.Attributes.class "foo" ] []
                  |> Query.fromHtml
                  |> Query.has [ class "cell", class "foo" ]
        , test "it should have class 'Nothing' if the cell has not been played" <|
            \_ ->
              let
                model = TicTacToeUI.new
              in
                TicTacToeUI.cell model Foo [] []
                  |> Query.fromHtml
                  |> Query.has [ class "Nothing" ]
        , test "it should have class 'X' if X has played the cell" <|
            \_ ->
              let
                model = TicTacToeUI.play Foo TicTacToeUI.new
              in
                TicTacToeUI.cell model Foo [] []
                  |> Query.fromHtml
                  |> Query.has [ class "X" ]
        , test "it should have class 'O' if O has played the cell" <|
            \_ ->
              let
                model = TicTacToeUI.play Bar (TicTacToeUI.play Foo TicTacToeUI.new)
              in
                TicTacToeUI.cell model Bar [] []
                  |> Query.fromHtml
                  |> Query.has [ class "O" ]
        ]
    , describe "update"
        [ test "it should play a position" <|
            \_ ->
              let
                model = TicTacToeUI.new
                subject = TicTacToeUI.update (Play Foo) model
              in
                Expect.equal (Just X) (Board.occupantOf Foo subject.board)
        ]
    ]
