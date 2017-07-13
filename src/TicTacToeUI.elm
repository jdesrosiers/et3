module TicTacToeUI exposing (Model, Msg(..), board, cell, heading, new, play, update)

import Html exposing (div, text)
import Html.Attributes exposing (class, id)
import Html.Events exposing (onClick)

import Board exposing (Board, Player, GameState(..))


-- MODEL

type alias Model pos =
  { board : Board pos }

new : Model pos
new =
  { board = Board.new }

-- UPDATE

type Msg pos =
  Play pos

play : pos -> Model pos -> Model pos
play position model =
  { model | board = Board.play position model.board }

update : Msg pos -> Model pos -> Model pos
update msg model =
  case msg of
    Play position -> play position model

-- VIEW

heading : Model pos -> String
heading model =
  case Board.state model.board of
    InProgress -> "Player " ++ (toString model.board.player) ++ "'s Turn"
    XWins -> "X Wins!"
    OWins -> "O Wins!"
    Draw -> "It's a Draw"

type alias Html pos =
  Html.Html (Msg pos)

type alias Attribute pos =
  Html.Attribute (Msg pos)

board : Model pos -> List (Attribute pos) -> List (Html pos) -> Html pos
board model attributes =
  let
    state = Board.state model.board
  in
    div (attributes ++ [ id "board", class (toString state), class "Human" ])

cell : Model pos -> pos -> List (Attribute pos) -> List (Html pos) -> Html pos
cell model position attributes =
  let
    player = Board.occupantOf position model.board
    state = Board.state model.board
    click =
      if state == InProgress && Board.occupantOf position model.board == Nothing then
        [ onClick (Play position) ]
      else
        []
  in
    div (attributes ++ [ class "cell", class (toString player) ] ++ click)
