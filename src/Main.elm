module Main exposing (board, cell, view)

import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, id, type_)


main : Program Never Model msg
main =
  Html.beginnerProgram { model = model , update = update , view = view }

-- MODEL

type alias Model =
  {}

model : Model
model =
  {}

-- UPDATE

update : a -> Model -> Model
update msg model = model

-- VIEW

view : Model -> Html msg
view model =
  div []
    [ h1 [ id "heading" ] [ text "Player X's Turn" ]
    , board [ class "container" ]
      [ div [ class "row" ]
          [ cell [ class "col-md-4" ] []
          , cell [ class "col-md-4" ] []
          , cell [ class "col-md-4" ] []
          ]
      , div [ class "row" ]
          [ cell [ class "col-md-4" ] []
          , cell [ class "col-md-4" ] []
          , cell [ class "col-md-4" ] []
          ]
      , div [ class "row" ]
          [ cell [ class "col-md-4" ] []
          , cell [ class "col-md-4" ] []
          , cell [ class "col-md-4" ] []
          ]
      ]
    , button [ id "new-game", type_ "button", class "btn btn-default" ] [ text "New Game" ]
  ]

board : List (Html.Attribute msg) -> List (Html msg) -> Html msg
board attributes =
  div (attributes ++ [ id "board", class "InProgress", class "Human" ])

cell : List (Html.Attribute msg) -> List (Html msg) -> Html msg
cell attributes =
  div (attributes ++ [ class "cell", class "Nothing" ])
