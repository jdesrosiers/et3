module MainSpec exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Test.Html.Selector exposing (class, classes, id, tag, text, attribute)
import Test.Html.Query as Query

import Html.Attributes

import Main


suite : Test
suite =
  describe "The Main module"
    [ describe "view"
        [ describe "heading"
            [ test "it should be X's turn first" <|
                \_ ->
                  Main.view {}
                    |> Query.fromHtml
                    |> Query.find [ id "heading" ]
                    |> Query.has [ text "Player X's Turn" ]
            ]
        , describe "new-game"
            [ test "it should be a button labeled New Game" <|
                \_ ->
                  Main.view {}
                    |> Query.fromHtml
                    |> Query.find [ id "new-game" ]
                    |> Query.has [ tag "button", attribute "type" "button", text "New Game" ]
            ]
        , describe "an empty board"
            [ test "it should have classes InProgress and Human" <|
                \_ ->
                  Main.view {}
                    |> Query.fromHtml
                    |> Query.find [ id "board" ]
                    |> Query.has [ classes [ "InProgress", "Human" ] ]
            , test "it should have nine cells" <|
                \_ ->
                  Main.view {}
                    |> Query.fromHtml
                    |> Query.findAll [ class "cell" ]
                    |> Query.count (Expect.equal 9)
            , test "it should have all empty cells" <|
                \_ ->
                  Main.view {}
                    |> Query.fromHtml
                    |> Query.findAll [ class "cell" ]
                    |> Query.each ( Query.has [ class "Nothing" ] )
            ]
        ]
    , describe "cell"
        [ test "it should have classes cell and Nothing and any other attributes passed in" <|
            \_ ->
              Main.cell [ Html.Attributes.class "foo" ] []
                |> Query.fromHtml
                |> Query.has [ class "cell", class "Nothing", class "foo" ]
        ]
    , describe "board"
        [ test "it should have classes board, InProgress, Human, and any other attributes passed in" <|
            \_ ->
              Main.board [ Html.Attributes.class "foo" ] []
                |> Query.fromHtml
                |> Query.has [ id "board", class "InProgress", class "Human", class "foo" ]
        ]
    ]
