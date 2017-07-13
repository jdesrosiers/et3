module AnyTypeSetSpec exposing (suite)

import Expect exposing (Expectation)
import Test exposing (Test, describe, test)

import Avl.Set as AvlSet

import AnyTypeSet as Set exposing (Set)
import Fixture exposing (Position(..))

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
                subject = Set.fromList [ A ]
              in
                Expect.equal [ A ] (Set.toList subject)
        ]
    , describe "member"
        [ test "it should be True if the item is in the set" <|
            \_ ->
              let
                subject = Set.fromList [ A ]
              in
                Expect.equal True (Set.member A subject)
        , test "it should be False if the item is not in the set" <|
            \_ ->
              let
                subject = Set.fromList [ A ]
              in
                Expect.equal False (Set.member B subject)
        ]
    , describe "insert"
        [ test "it should add an item to the set" <|
          \_ ->
            let
              subject = Set.insert A Set.empty
            in
              Expect.equal True (Set.member A subject)
        ]
    , describe "subset"
        [ test "it should be True if it is a subset" <|
            \_ -> Expect.equal True (Set.subset (Set.fromList [ B, C ]) (Set.fromList [ A, B, C, D]))
        ]
    , describe "diff"
        [ test "it should return the difference of the two sets" <|
            \_ ->
              let
                a = Set.fromList [ A, B, C, D ]
                b = Set.fromList [ A, B ]
                expected = Set.fromList [ C, D ]
              in
                Expect.equal expected (Set.diff a b)
        ]
    , describe "union"
        [ test "it should return the union of the two sets" <|
            \_ ->
              let
                a = Set.fromList [ C ]
                b = Set.fromList [ A, B ]
                expected = Set.fromList [ A, B, C ]
              in
                Expect.equal expected (Set.union a b)
        ]
    ]
