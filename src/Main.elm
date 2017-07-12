module Main exposing (board, cell, heading, view)

import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, id, type_)

import Board exposing (Board, GameState(..), Player, Position(..), new)


main : Program Never Model msg
main =
  Html.beginnerProgram { model = model, update = update, view = view }

-- MODEL

type alias Model =
  { board : Board }

model : Model
model =
  { board = Board.new }

-- UPDATE

update : a -> Model -> Model
update msg model =
  model

-- VIEW

view : Model -> Html msg
view model =
  let
    state = Board.state model.board
    player = model.board.player
  in
    div []
      [ h1 [ id "heading" ] [ text (heading state player) ]
      , board state [ class "container" ]
        [ div [ class "row" ]
            [ cell (Board.occupantOf TopLeft model.board) [ class "col-md-4" ] []
            , cell (Board.occupantOf TopMiddle model.board) [ class "col-md-4" ] []
            , cell (Board.occupantOf TopRight model.board) [ class "col-md-4" ] []
            ]
        , div [ class "row" ]
            [ cell (Board.occupantOf MiddleLeft model.board) [ class "col-md-4" ] []
            , cell (Board.occupantOf Center model.board) [ class "col-md-4" ] []
            , cell (Board.occupantOf MiddleRight model.board) [ class "col-md-4" ] []
            ]
        , div [ class "row" ]
            [ cell (Board.occupantOf BottomLeft model.board) [ class "col-md-4" ] []
            , cell (Board.occupantOf BottomMiddle model.board) [ class "col-md-4" ] []
            , cell (Board.occupantOf BottomRight model.board) [ class "col-md-4" ] []
            ]
        ]
      , button [ id "new-game", type_ "button", class "btn btn-default" ] [ text "New Game" ]
    ]

heading : GameState -> Player -> String
heading state player =
  case state of
    InProgress -> "Player " ++ (toString player) ++ "'s Turn"
    XWins -> "X Wins!"
    OWins -> "O Wins!"
    Draw -> "It's a Draw"

board : GameState -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
board state attributes =
  div (attributes ++ [ id "board", class (toString state), class "Human" ])

cell : Maybe Player -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
cell player attributes =
  div (attributes ++ [ class "cell", class (toString player) ])
