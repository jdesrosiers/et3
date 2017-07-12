module MainSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)
import Test.Html.Selector exposing (class, classes, id, tag, text, attribute)
import Test.Html.Query as Query

import Html.Attributes

import Board exposing (Board, GameState(..), Player(..), new)
import Main


suite : Test
suite =
  describe "The Main module"
    [ describe "view"
        [ describe "heading"
            [ test "it should be X's turn first" <|
                \_ ->
                  Main.view { board = Board.new }
                    |> Query.fromHtml
                    |> Query.find [ id "heading" ]
                    |> Query.has [ text "Player X's Turn" ]
            ]
        , describe "new-game"
            [ test "it should be a button labeled 'New Game'" <|
                \_ ->
                  Main.view { board = Board.new }
                    |> Query.fromHtml
                    |> Query.find [ id "new-game" ]
                    |> Query.has [ tag "button", attribute "type" "button", text "New Game" ]
            ]
        , describe "an empty board"
            [ test "it should have classes 'InProgress' and 'Human'" <|
                \_ ->
                  Main.view { board = Board.new }
                    |> Query.fromHtml
                    |> Query.find [ id "board" ]
                    |> Query.has [ classes [ "InProgress", "Human" ] ]
            , test "it should have nine cells" <|
                \_ ->
                  Main.view { board = Board.new }
                    |> Query.fromHtml
                    |> Query.findAll [ class "cell" ]
                    |> Query.count (Expect.equal 9)
            , test "it should have all empty cells" <|
                \_ ->
                  Main.view { board = Board.new }
                    |> Query.fromHtml
                    |> Query.findAll [ class "cell" ]
                    |> Query.each ( Query.has [ class "Nothing" ] )
            ]
        ]
    , describe "heading"
        [ test "it should indicate that it is X's turn" <|
            \_ -> Expect.equal "Player X's Turn" (Main.heading InProgress X)
        , test "it should indicate it is O's turn" <|
            \_ -> Expect.equal "Player O's Turn" (Main.heading InProgress O)
        , test "it should indicate X has won" <|
            \_ -> Expect.equal "X Wins!" (Main.heading XWins O)
        , test "it should indicate O has won" <|
            \_ -> Expect.equal "O Wins!" (Main.heading OWins X)
        , test "it should indicate the game is draw" <|
            \_ -> Expect.equal "It's a Draw" (Main.heading Draw X)
        ]
    , describe "board"
        [ test "it should have classes 'board', 'Human', and any other attributes passed in" <|
            \_ ->
              Main.board InProgress [ Html.Attributes.class "foo" ] []
                |> Query.fromHtml
                |> Query.has [ id "board", class "InProgress", class "Human", class "foo" ]
        , test "it should have classes 'InProgress'" <|
            \_ ->
              Main.board InProgress [ Html.Attributes.class "foo" ] []
                |> Query.fromHtml
                |> Query.has [ class "InProgress" ]
        ]
    , describe "cell"
        [ test "it should have classes 'cell' and any other attributes passed in" <|
            \_ ->
              Main.cell Nothing [ Html.Attributes.class "foo" ] []
                |> Query.fromHtml
                |> Query.has [ class "cell", class "foo" ]
        , test "it should have class 'Nothing' if the cell has not been played" <|
            \_ ->
              Main.cell Nothing [] []
                |> Query.fromHtml
                |> Query.has [ class "Nothing" ]
        , test "it should have class 'X' if X has played the cell" <|
            \_ ->
              Main.cell (Just X) [] []
                |> Query.fromHtml
                |> Query.has [ class "X" ]
        , test "it should have class 'O' if O has played the cell" <|
            \_ ->
              Main.cell (Just O) [] []
                |> Query.fromHtml
                |> Query.has [ class "O" ]
        ]
    ]
