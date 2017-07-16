module Main exposing (view)

import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class)

import Classic exposing (Position(..))
import TicTacToeUI exposing (Model, Msg(..), newGameButton)


main : Program Never (Model Position) (Msg Position)
main =
  TicTacToeUI.program Classic.new view

view : Model Position -> Html (Msg Position)
view model =
  let
    board = TicTacToeUI.board model
    cell = TicTacToeUI.cell model
  in
    div []
      [ h1 [ class "heading" ] [ text (TicTacToeUI.heading model) ]
      , board [ class "container" ]
        [ div [ class "row" ]
            [ cell TopLeft [ class "col-md-4" ] []
            , cell TopMiddle [ class "col-md-4" ] []
            , cell TopRight [ class "col-md-4" ] []
            ]
        , div [ class "row" ]
            [ cell MiddleLeft [ class "col-md-4" ] []
            , cell Center [ class "col-md-4" ] []
            , cell MiddleRight [ class "col-md-4" ] []
            ]
        , div [ class "row" ]
            [ cell BottomLeft [ class "col-md-4" ] []
            , cell BottomMiddle [ class "col-md-4" ] []
            , cell BottomRight [ class "col-md-4" ] []
            ]
        ]
      , newGameButton [ class "btn btn-default" ] [ text "New Game" ]
    ]
