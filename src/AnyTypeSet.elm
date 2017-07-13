module AnyTypeSet exposing (Set, empty, fromList, insert, isEmpty, member, toList)

import Avl.Set as AvlSet


type alias Set k =
  AvlSet.Set k

toStringCompare : k -> k -> Order
toStringCompare a b =
  compare (toString a) (toString b)

empty : Set k
empty =
  AvlSet.empty

insert : k -> Set k -> Set k
insert =
  AvlSet.insert toStringCompare

isEmpty : Set k -> Bool
isEmpty =
  AvlSet.isEmpty

toList : Set k -> List k
toList =
  AvlSet.toList

fromList : List k -> Set k
fromList =
  AvlSet.fromList toStringCompare

member : k -> Set k -> Bool
member =
  AvlSet.member toStringCompare
