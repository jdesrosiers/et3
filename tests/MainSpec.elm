module MainSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)
import Test.Html.Selector exposing (class, classes, text)
import Test.Html.Query as Query

import Classic
import Main
import TicTacToeUI


suite : Test
suite =
  describe "The Main module"
    [ describe "view"
        [ describe "heading"
            [ test "it should be X's turn first" <|
                \_ ->
                  Main.view (TicTacToeUI.Model Classic.new)
                    |> Query.fromHtml
                    |> Query.find [ class "heading" ]
                    |> Query.has [ text "Player X's Turn" ]
            ]
        , describe "new-game"
            [ test "it should be a button labeled 'New Game'" <|
                \_ ->
                  Main.view (TicTacToeUI.Model Classic.new)
                    |> Query.fromHtml
                    |> Query.find [ class "new-game" ]
                    |> Query.has [ text "New Game" ]
            ]
        , describe "an empty board"
            [ test "it should have classes 'InProgress' and 'Human'" <|
                \_ ->
                  Main.view (TicTacToeUI.Model Classic.new)
                    |> Query.fromHtml
                    |> Query.find [ class "board" ]
                    |> Query.has [ classes [ "InProgress", "Human" ] ]
            , test "it should have nine cells" <|
                \_ ->
                  Main.view (TicTacToeUI.Model Classic.new)
                    |> Query.fromHtml
                    |> Query.findAll [ class "cell" ]
                    |> Query.count (Expect.equal 9)
            , test "it should have all empty cells" <|
                \_ ->
                  Main.view (TicTacToeUI.Model Classic.new)
                    |> Query.fromHtml
                    |> Query.findAll [ class "cell" ]
                    |> Query.each ( Query.has [ class "Nothing" ] )
            ]
        ]
    ]
