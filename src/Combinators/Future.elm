module Combinators.Future exposing (bo, bt, ckm, km, l, m, m2, u, y)

{-| Future combinators.

@docs bo, bt, ckm, km, l, m, m2, u, y

-}


{-| The Big Omega (Ω) combinator.

Named 'bo' due to Elm's lack of Unicode support in function names.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.Future.m Combinators.Future.m` if that happens.

    Combinators.Future.bo --> Err "Unimplementable until the M combinator is implemented."

-}
bo : Result String value
bo =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The Big Theta (ϴ) combinator.

Named 'bt' due to Elm's lack of Unicode support in function names.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.Future.y Combinators.o` if that happens.

    Combinators.Future.bt --> Err "Unimplementable until the M combinator is implemented."

-}
bt : Result String value
bt =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The Crossed Konstant Mocker combinator.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.Future.c (Combinators.k Combinators.m)` if that happens.

    Combinators.Future.ckm --> Err "Unimplementable until the M combinator is implemented."

-}
ckm : Result String value
ckm =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The Konstant Mocker combinator.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.k Combinators.Future.m` if that happens.

    Combinators.Future.km --> Err "Unimplementable until the M combinator is implemented."

-}
km : Result String value
km =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The L combinator.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.c Combinators.b Combinators.Future.m` if that ever becomes possible.

    Combinators.Future.l --> Err "Unimplementable until the M combinator is implemented."

-}
l : Result String value
l =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The M combinator.

Currently unable to implement due to requiring infinite type recursion.

Implementable as `Combinators.s Combinators.i Combinators.i` if that ever becomes possible.

    Combinators.Future.m --> Err "Unimplemented currently."

-}
m : Result String value
m =
    Result.Err "Unimplemented currently."


{-| The M2 combinator.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.b Combinators.Future.m` if that happens.

    Combinators.Future.m2 --> Err "Unimplementable until the M combinator is implemented."

-}
m2 : Result String value
m2 =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The U combinator.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.Future.l Combinators.o` if that happens.

    Combinators.Future.u --> Err "Unimplementable until the M combinator is implemented."

-}
u : Result String value
u =
    Result.Err "Unimplementable until the M combinator is implemented."


{-| The Y combinator.

Currently unable to implement due the M combinator requiring infinite type recursion.

Implementable as `Combinators.s Combinators.Future.l Combinators.Future.l` if that happens.

    Combinators.Future.y --> Err "Unimplementable until the M combinator is implemented."

-}
y : Result String value
y =
    Result.Err "Unimplementable until the M combinator is implemented."
