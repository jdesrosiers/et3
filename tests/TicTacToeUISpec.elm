module TicTacToeUISpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)
import Test.Html.Selector exposing (class, id)
import Test.Html.Query as Query

import Html.Attributes

import TicTacToe exposing (GameState(..), Player(..))
import TicTacToeUI exposing (Msg(..))
import Fixture exposing (Position(..))


suite : Test
suite =
  describe "The TicTacToeUI module"
    (let
      model = TicTacToeUI.Model Fixture.new
    in
      [ describe "heading"
          [ test "it should indicate that it is X's turn" <|
              \_ -> Expect.equal "Player X's Turn" (TicTacToeUI.heading model)
          , test "it should indicate it is O's turn" <|
              \_ -> Expect.equal "Player O's Turn" (TicTacToeUI.heading (TicTacToeUI.play A model))
          ]
      , describe "board"
          [ test "it should have classes 'board', 'Human', and any other attributes passed in" <|
              \_ ->
                TicTacToeUI.board model [ Html.Attributes.class "foo" ] []
                  |> Query.fromHtml
                  |> Query.has [ id "board", class "Human", class "foo" ]
          , test "it should have class 'InProgress'" <|
              \_ ->
                TicTacToeUI.board model [ Html.Attributes.class "foo" ] []
                  |> Query.fromHtml
                  |> Query.has [ class "InProgress" ]
          ]
      , describe "cell"
          [ test "it should have classes 'cell' and any other attributes passed in" <|
              \_ ->
                TicTacToeUI.cell model A [ Html.Attributes.class "foo" ] []
                  |> Query.fromHtml
                  |> Query.has [ class "cell", class "foo" ]
          , test "it should have class 'Nothing' if the cell has not been played" <|
              \_ ->
                TicTacToeUI.cell model A [] []
                  |> Query.fromHtml
                  |> Query.has [ class "Nothing" ]
          , test "it should have class 'X' if X has played the cell" <|
              \_ ->
                TicTacToeUI.cell (TicTacToeUI.play A model) A [] []
                  |> Query.fromHtml
                  |> Query.has [ class "X" ]
          , test "it should have class 'O' if O has played the cell" <|
              \_ ->
                let
                  model2 = TicTacToeUI.play B (TicTacToeUI.play A model)
                in
                  TicTacToeUI.cell model2 B [] []
                    |> Query.fromHtml
                    |> Query.has [ class "O" ]
          ]
      , describe "update"
          [ test "it should play a position" <|
              \_ ->
                let
                  subject = TicTacToeUI.update (Play A) model
                in
                  Expect.equal (Just X) (TicTacToe.occupantOf A subject.board)
          ]
    ])
