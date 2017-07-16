module TicTacToeUI exposing
  ( Model, Msg(..), PlayerType(..)
  , board, cell, heading, newGameButton, play, program, subscriptions, update
  )

import Html exposing (a, div)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Time exposing (Time, second)

import Minimax
import TicTacToe exposing (Board, Player, GameState(..))


program : Board pos -> (Model pos -> Html.Html (Msg pos)) -> Program Never (Model pos) (Msg pos)
program board view =
  Html.program
    { init = (Model board Human, Cmd.none)
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type PlayerType =
  Human | Minimax

type alias Model pos =
  { board : Board pos
  , playerType : PlayerType
  }

-- UPDATE

type Msg pos =
  Play pos | Tick Time

play : pos -> Model pos -> Model pos
play position model =
  let
    board = TicTacToe.play position model.board
  in
    case model.playerType of
      Human -> { model | playerType = Minimax, board = board }
      Minimax -> { model | playerType = Human, board = board }

update : Msg pos -> Model pos -> (Model pos, Cmd (Msg pos))
update msg model =
  case msg of
    Play position -> (play position model, Cmd.none)
    Tick _ ->
      (if model.playerType == Minimax then Minimax.getMove model.board else Nothing)
        |> Maybe.map (\(position) -> (play position model, Cmd.none))
        |> Maybe.withDefault (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model pos -> Sub (Msg pos)
subscriptions model =
  Time.every second Tick

-- VIEW

heading : Model pos -> String
heading model =
  case TicTacToe.state model.board of
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
    state = TicTacToe.state model.board
  in
    div (attributes ++ [ class "board", class (toString state), class (toString model.playerType) ])

cell : Model pos -> pos -> List (Attribute pos) -> List (Html pos) -> Html pos
cell model position attributes =
  let
    player = TicTacToe.occupantOf position model.board
    state = TicTacToe.state model.board
    click =
      if state == InProgress && TicTacToe.occupantOf position model.board == Nothing then
        [ onClick (Play position) ]
      else
        []
  in
    div (attributes ++ [ class "cell", class (toString player) ] ++ click)

newGameButton : List (Attribute pos) -> List (Html pos) -> Html pos
newGameButton attributes =
  a ([ href "", class "new-game" ] ++ attributes)
