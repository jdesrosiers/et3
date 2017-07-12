module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, list, int, string)
import Test exposing (..)
import Test.Html.Selector exposing (text)
import Test.Html.Query as Query

import Main


suite : Test
suite =
  describe "The Main module"
    [ test "it should greet the world" <|
        \_ ->
          Main.view
            |> Query.fromHtml
            |> Query.has [ text "Hello World!" ]
    ]
