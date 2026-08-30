module Combinators exposing (a, b, b1, b2, b3, bp, c, cp, cs, css, d, d1, d2, e, eb, f, fs, fss, g, h, i, is, iss, j, js, jp, k, ki, o, p, px, q, q1, q2, q3, q4, r, rs, rss, s, sp, t, v, vs, vss, w, w1, ws, wss)

{-|

@docs a, b, b1, b2, b3, bp, c, cp, cs, css, d, d1, d2, e, eb, f, fs, fss, g, h, i, is, iss, j, js, jp, k, ki, o, p, px, q, q1, q2, q3, q4, r, rs, rss, s, sp, t, v, vs, vss, w, w1, ws, wss

-}


{-| The A combinator.

Implemented in terms of the [I](#i) combinator.

    Combinators.a String.fromInt 1 --> "1"

    Combinators.a List.sum [ 1, 2, 3 ] --> 6

-}
a : (a -> b) -> a -> b
a =
    i


{-| The B combinator.

The equivilent of the composition operator (`(<<)`) in Elm.

    isEven : Int -> Bool
    isEven n = modBy 2 n == 0

    double : number -> number
    double = ((*) 2)

    Combinators.b not isEven 2 --> False
    Combinators.b not isEven 1 --> True
    Combinators.b String.fromInt double 4 --> "8"

-}
b : (b -> c) -> (a -> b) -> a -> c
b =
    s (k s) k


{-| The B1 combinator.

    Combinators.b1 String.toFloat String.append "3" ".14" --> Just 3.14

    Combinators.b1 (modBy 2) (\x y -> x * y) 2 3 --> 0

-}
b1 : (b -> c) -> (a -> d -> b) -> a -> d -> c
b1 =
    b b b


{-| The B2 combinator.

    createUser : String -> Int -> Bool -> { name : String , age : Int , online : Bool }
    createUser name age online = {
        name = name ,
        age = age ,
        online = online
        }

    incrementUserAge : { name : String , age : Int , online : Bool } -> { name : String , age : Int , online : Bool }
    incrementUserAge user =
        { user | age = user.age + 1 }

    Combinators.b2 List.sum (\x y z -> [x, y, z]) 1 2 3 --> 6
    Combinators.b2 incrementUserAge createUser "John" 36 True --> { name = "John", age = 37, online = True }

-}
b2 : (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
b2 =
    b (b b b) b


{-| The B3 combinator.

    Combinators.b3 (\n -> n + 15) (\n -> n - 10) (\n -> n * 2) 50 --> 105

    Combinators.b3 (Combinators.c String.append "1") ((++) "2") String.fromInt 50 --> "2501"

-}
b3 : (c -> d) -> (b -> c) -> (a -> b) -> a -> d
b3 =
    b (b b) b


{-| The B Prime (B') combinator.

    Combinators.bp (+) 1 Basics.identity 2 --> 3

    Combinators.bp (++) [ 1, 2, 3 ] List.singleton 4 --> [1, 2, 3, 4]

-}
bp : (a -> c -> d) -> a -> (b -> c) -> b -> d
bp bf x uf y =
    bf x (uf y)


{-| The C combinator.

Takes a binary function and two further arguments which are then applied inversely.

    multiplyList : List Int -> Int -> List Int
    multiplyList items multiple =
        List.map ((*) multiple) items

    Combinators.c multiplyList 10 [1, 2, 3] --> [10, 20, 30]

Useful in pipelines where the piped value is required to be the first argument to a function.

    [1, 2, 3]
        |> Combinators.c multiplyList 5
        |> List.sum
    --> 30

-}
c : (a -> b -> c) -> b -> a -> c
c =
    s (b b s) (k k)


{-| The C Prime (C') combinator.

    Combinators.cp (+) (\x -> x * 2) 3 4 --> 11

    Combinators.cp List.append List.singleton [ 3, 2, 1 ] 4 --> [4, 3, 2, 1]

-}
cp : (c -> a -> d) -> (b -> c) -> a -> b -> d
cp bf uf x y =
    bf (uf y) x


{-| The C Star (C\*) combinator.

Flips the third and fourth arguments when applied to the given ternary function.

    Combinators.cs Basics.clamp 100 200 150 --> 150

    Combinators.cs (\four six three -> four + six * three) 4 3 6 --> 22

-}
cs : (a -> c -> b -> d) -> a -> b -> c -> d
cs =
    b c


{-| The C Star Star (C\*\*) combinator.

Flips the fourth and fifth arguments when applied to the given quaternary function.

    Combinators.css (\two four six three -> (two - four + six) * three) 2 4 3 6 --> 12

-}
css : (a -> b -> d -> c -> e) -> a -> b -> c -> d -> e
css =
    b cs


{-| The D combinator.

Calls a given function with a given argument.

Sometimes referred to as "the reverse pipe operator".

The equivilent of the "pipe left" operator `(<|)` in Elm.

    Combinators.d (+) 5 Basics.identity 2 --> 7

-}
d : (a -> c -> d) -> a -> (b -> c) -> b -> d
d =
    b b


{-| The D1 Combinator.

    Combinators.d1 Basics.clamp 100 200 ((*) 2) 110 --> 200

-}
d1 : (a -> b -> d -> e) -> a -> b -> (c -> d) -> c -> e
d1 =
    b (b b)


{-| The D2 combinator.

    Combinators.d2 (+) Basics.identity 2 ((*) 2) 11 --> 24

-}
d2 : (c -> d -> e) -> (a -> c) -> a -> (b -> d) -> b -> e
d2 =
    b b (b b)


{-| The E combinator.

    Combinators.e (+) 6 (*) 2 3 --> 12

-}
e : (a -> d -> e) -> a -> (b -> c -> d) -> b -> c -> e
e =
    b (b b b)


{-| The Ê Combinator.

Named 'eb' for alphabetic consistency with the [e combinator](#e).

I would have named this function 'ê' but Elm does not support that as a function name in the @docs block. Accordingly, this was the next best name I could think of based on other language / library implementations I have seen.

    Combinators.eb (+) (-) 50 25 (*) 3 2 --> 31

-}
eb :
    (e -> f -> g)
    -> (a -> b -> e)
    -> a
    -> b
    -> (c -> d -> f)
    -> c
    -> d
    -> g
eb =
    b (b b b) (b (b b b))


{-| The F combinator.

    Combinators.f 6 2 (-) --> -4

    Combinators.f "Hi" 3 String.repeat --> "HiHiHi"

-}
f : a -> b -> (b -> a -> c) -> c
f =
    e t t e t


{-| The F Star (F\*) combinator.

Equivilant to [S Prime](#sp) here and known to Haskell programmers as liftA2 and liftM2 for the Applicative and Monadic instances of (->).

    Combinators.fs Basics.clamp 120 200 100 --> 120

-}
fs : (c -> b -> a -> d) -> a -> b -> c -> d
fs =
    b cs rs


{-| The F Star Star (F\*\*) combinator.

Flips the third and fifth arguments when applied to the given quaternary function.

-}
fss : (a -> d -> c -> b -> e) -> a -> b -> c -> d -> e
fss =
    b fs


{-| The G combinator.

    Combinators.g (+) ((*) 2) 6 1 --> 13

-}
g : (b -> c -> d) -> (a -> c) -> a -> b -> d
g =
    b b c


{-| The H combinator.

    Combinators.h (\x1 y x2 -> ( x1, x2, y )) 1 2 --> (1, 1, 2)

-}
h : (a -> b -> a -> c) -> a -> b -> c
h =
    b w (b c)


{-| The I combinator.

Returns whatever it is given.

    Combinators.i 1 --> 1

    Combinators.i [ 1, 2, 3 ] --> [1, 2, 3]

    Combinators.i String.fromInt --> String.fromInt

-}
i : a -> a
i =
    s k k


{-| The I Star (I\*) combinator

Implemented in terms of the [I](#i) combinator.

    Combinators.is (\n -> n - 1) 10 --> 9

-}
is : (a -> b) -> a -> b
is =
    i


{-| The I Star Star (I\*\*) combinator.

Implemented in terms of the [I](#i) combinator.

    Combinators.iss (\n m -> n - m) 10 4 --> 6

-}
iss : (a -> b -> c) -> a -> b -> c
iss =
    i


{-| The J combinator.

This is the J combinator of the literature.

    Combinators.j (+) 10 20 40 --> 70

-}
j : (a -> b -> b) -> a -> b -> a -> b
j =
    b (b c) (w (b c (b (b b b))))


{-| The J Star (J\*) combinator.

This is the J combinator of Joy. It is not the jay combinator (J) of the literature.

Credit: Rayward-Smith and Burton (See Antoni Diller 'Compiling Functional Languages' page 104).

    Combinators.js Basics.identity 10 20 --> 10

-}
js : (a -> c) -> a -> b -> c
js uf x _ =
    uf x


{-| The J Prime (J') combinator - prime of the [J Star](#js) (Joy) combinator.

Credit: Rayward-Smith and Burton (See Antoni Diller 'Compiling Functional Languages' page 104).

    Combinators.jp (+) 10 20 40 --> 30

-}
jp : (a -> b -> d) -> a -> b -> c -> d
jp bf x y _ =
    bf x y


{-| The K combinator.

Corresponds to the encoding of `true` in lambda calculus.

Returns the first argument provided, ignoring the second.

    Combinators.k "hello" 2 --> "hello"

    Combinators.k Nothing [ 1, 2, 3 ] --> Nothing

    Combinators.k String.fromInt (Just 2) --> String.fromInt

-}
k : a -> b -> a
k =
    Basics.always


{-| The KI combinator.

Corresponds to the encoding of `false` in lambda calculus.

Returns the second argument provided, ignoring the first.

    Combinators.ki "hello" 2 --> 2

    Combinators.ki Nothing [ 1, 2, 3 ] --> [ 1, 2, 3 ]

    Combinators.ki String.fromInt (Just 2) --> Just 2

-}
ki : a -> b -> b
ki =
    k i


{-| The O combinator.

    Combinators.o (\f -> f 2 6) (+) 5 --> 13

-}
o : ((a -> b) -> a) -> (a -> b) -> b
o x y =
    y (x y)


{-| The P combinator.

Transforms two inputs and combines the outputs.

Equivelent of the [on](https://hackage.haskell.org/package/base-4.17.0.0/docs/Data-Function.html#v:on) operator in Haskell.

    add : number -> number -> number
    add = (+)

    double : number -> number
    double = ((*) 2)

    Combinators.p add double 3 12 --> 30

-}
p : (b -> b -> c) -> (a -> b) -> a -> a -> c
p bf uf x y =
    bf (uf x) (uf y)


{-| The Pheonix (Big Phi) combinator, also known as Turner's S Prime (S') combinator.

Equivilant to [S Prime](#sp) here and known to Haskell programmers as liftA2 and liftM2 for the Applicative and Monadic instances of (->).

    Combinators.px (+) ((*) 2) ((-) 3) 5 --> 8

-}
px : (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
px =
    sp


{-| The Q combinator.

Reverse function composition.

    Combinators.q ((+) 2) ((*) 4) 10 --> 48

    Combinators.q String.toUpper (\name -> "My name is " ++ name) "John" --> "My name is JOHN"

-}
q : (a -> b) -> (b -> c) -> a -> c
q =
    c b


{-| The Q1 combinator.

    Combinators.q1 ((+) 2) 10 ((*) 4) --> 42

    Combinators.q1 String.toUpper "John" (\name -> "My name is " ++ name) --> "MY NAME IS JOHN"

-}
q1 : (b -> c) -> a -> (a -> b) -> c
q1 =
    b c b


{-| The Q2 combinator.

    Combinators.q2 10 ((+) 2) ((*) 4) --> 42

    Combinators.q2 "John" String.toUpper (\name -> "My name is " ++ name) --> "MY NAME IS JOHN"

-}
q2 : a -> (b -> c) -> (a -> b) -> c
q2 =
    c (b c b)


{-| The Q3 combinator.

    Combinators.q3 ((+) 2) 10 ((*) 4) --> 48

    Combinators.q3 String.toUpper "John" (\name -> "My name is " ++ name) --> "My name is JOHN"

-}
q3 : (a -> b) -> a -> (b -> c) -> c
q3 =
    b t


{-| The Q4 combinator.

    Combinators.q4 10 ((+) 2) ((*) 4) --> 48

    Combinators.q4 "John" String.toUpper (\name -> "My name is " ++ name) --> "My name is JOHN"

-}
q4 : a -> (a -> b) -> (b -> c) -> c
q4 =
    fs b


{-| The R combinator.

    Combinators.r 10 (-) 12 --> 2

    Combinators.r "second" (\a b -> a ++ " " ++ b) "first" --> "first second"

-}
r : a -> (b -> a -> c) -> b -> c
r =
    b b t


{-| The R Star (R\*) combinator.

Reverses the second, third and fourth arguments when applied to the given ternary function.

    Combinators.rs Basics.clamp 10 100 200 --> 100

    Combinators.rs Basics.clamp 110 100 200 --> 110

    Combinators.rs Basics.clamp 220 100 200 --> 200

-}
rs : (b -> c -> a -> d) -> a -> b -> c -> d
rs =
    cs cs


{-| The R Star Star (R\*\*) combinator.

Flips the third and fifth arguments when applied to the given quaternary function.

    Combinators.rss (\six nine ten four -> six - nine + ten * four) 6 4 9 10 --> 37

-}
rss : (a -> c -> d -> b -> e) -> a -> b -> c -> d -> e
rss =
    b rs


{-| The S combinator.

    Combinators.s (+) ((*) 2) 10 --> 30

    Combinators.s (-) (\v -> v * 7) 4 --> -24

    Combinators.s (\user newAge -> { user | age = newAge }) (\user -> user.age + 1) { age = 35 } --> { age = 36 }

-}
s : (a -> b -> c) -> (a -> b) -> a -> c
s bf uf x =
    bf x (uf x)


{-| The S Prime (S') combinator.

    Combinators.sp (+) ((*) 2) ((-) 3) 5 --> 8

-}
sp : (b -> c -> d) -> (a -> b) -> (a -> c) -> a -> d
sp bf uf1 uf2 x =
    bf (uf1 x) (uf2 x)


{-| The T combinator.

Sometimes referred to as "the forward pipe operator".

The equivilent of the "pipe right" operator `(|>)` in Elm.

    Combinators.t 1 Basics.identity --> 1

    Combinators.t 20 ((+) 2) --> 22

    Combinators.t "Hello" (\v -> v ++ " world!") --> "Hello world!"

-}
t : a -> (a -> b) -> b
t =
    c i


{-| The V combinator.

    Combinators.v 1 2 (+) --> 3

    Combinators.v 3 "Hello" String.repeat --> "HelloHelloHello"

-}
v : a -> b -> (a -> b -> c) -> c
v =
    b c t


{-| The V Star (V\*) combinator.

    Combinators.vs (\two one three -> one + two - three) 1 2 3 --> 0

-}
vs : (b -> a -> b -> d) -> a -> b -> b -> d
vs tf x y z =
    tf y x z


{-| The V Star Star (V\*\*) combinator.

    Combinators.vss (\one four two three -> (one + two) - (three + four)) 1 2 3 4 --> -4

-}
vss : (a -> c -> b -> c -> e) -> a -> b -> c -> c -> e
vss qf x y z l =
    qf x l y z


{-| The W combinator.

Provides a given argument as both values to a given binary function.

    Combinators.w (+) 2 --> 4

-}
w : (a -> a -> b) -> a -> b
w bf x =
    -- Can be implemented as `c b m r` if the M combinator is ever implementable.
    bf x x


{-| The W1 combinator.

The [W](#w) combinator but with the arguments reversed.

Converse warbler.

    Combinators.w1 2 (+) --> 4

-}
w1 : a -> (a -> a -> b) -> b
w1 =
    c w


{-| The W Star (W\*) combinator.

Warbler once removed.

    Combinators.ws (\x y z -> [ x, y, z ]) 1 2 --> [1, 2, 2]

-}
ws : (a -> b -> b -> c) -> a -> b -> c
ws =
    b w


{-| The W Star Star (W\*\*) combinator.

Warbler twice removed.

    Combinators.wss (\w x y z -> [ w, x, y, z ]) 1 2 3 --> [1, 2, 3, 3]

-}
wss : (a -> b -> c -> c -> d) -> a -> b -> c -> d
wss =
    b (b w)
