module AnyTypeSetSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)

import Avl.Set as AvlSet

import AnyTypeSet as Set exposing (Set)

type Fixture =
  Foo | Bar

suite =
  describe "A Set"
    [ describe "empty"
        [ test "it should return an empty set" <|
            \_ ->
              let
                subject = Set.empty
              in
                Expect.equal True (Set.isEmpty subject)
        ]
    , describe "toList"
        [ test "it should create a set from a list" <|
            \_ ->
              let
                subject = Set.fromList [ Foo ]
              in
                Expect.equal [ Foo ] (Set.toList subject)
        ]
    , describe "member"
        [ test "it should be True if the item is in the set" <|
            \_ ->
              let
                subject = Set.fromList [ Foo ]
              in
                Expect.equal True (Set.member Foo subject)
        , test "it should be False if the item is not in the set" <|
            \_ ->
              let
                subject = Set.fromList [ Foo ]
              in
                Expect.equal False (Set.member Bar subject)
        ]
    , describe "insert"
        [ test "it should add an item to the set" <|
          \_ ->
            let
              subject = Set.insert Foo Set.empty
            in
              Expect.equal True (Set.member Foo subject)
        ]
    ]
