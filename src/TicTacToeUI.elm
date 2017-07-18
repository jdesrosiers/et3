module TicTacToeUI exposing
  ( Model, Msg(..), PlayerType(..)
  , board, cell, heading, newGameButton, play, program, subscriptions, update
  )

import Html exposing (a, div)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Maybe.Extra
import Process
import Task
import Time exposing (Time)

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
  Play pos | TurnCompleted

play : pos -> Model pos -> Model pos
play position model =
  let
    board = TicTacToe.play position model.board
  in
    case model.playerType of
      Human -> { model | playerType = Minimax, board = board }
      Minimax -> { model | playerType = Human, board = board }

isMinimaxTurn : Model pos -> Bool
isMinimaxTurn model =
  model.playerType == Minimax

toDelayedCmd : Time -> msg -> Cmd msg
toDelayedCmd delay msg =
  Process.sleep delay |> Task.map (always msg) |> Task.perform identity

update : Msg pos -> Model pos -> (Model pos, Cmd (Msg pos))
update msg model =
  case msg of
    Play position ->
      -- Pause briefly to allow the view to update before minimax runs
      play position model ! [ TurnCompleted |> toDelayedCmd 50 ]
    TurnCompleted ->
      Just model
        |> Maybe.Extra.filter isMinimaxTurn
        |> Maybe.map (\model -> Minimax.getMove model.board)
        |> Maybe.Extra.join -- flatten Maybes
        |> Maybe.map (\position -> update (Play position) model)
        |> Maybe.withDefault (model ! [])

-- SUBSCRIPTIONS

subscriptions : Model pos -> Sub (Msg pos)
subscriptions model =
  Sub.none

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
    isHumansMove = state == InProgress && model.playerType == Human
    click =
      if isHumansMove && TicTacToe.occupantOf position model.board == Nothing then
        [ onClick (Play position) ]
      else
        []
  in
    div (attributes ++ [ class "cell", class (toString player) ] ++ click)

newGameButton : List (Attribute pos) -> List (Html pos) -> Html pos
newGameButton attributes =
  a ([ href "", class "new-game" ] ++ attributes)
