# ELM Combinators

An elm [combinatory logic](https://en.wikipedia.org/wiki/Combinatory_logic) library.

Each combinator represents a [function composition pattern](https://en.wikipedia.org/wiki/Function_composition) and each is implemented, as far as is possible, using [SKI combinator calculus](https://en.wikipedia.org/wiki/SKI_combinator_calculus) under the hood.

## Installation

```sh
elm install jamesrweb/elm-combinators
```

## Usage

To import all combinators, add the following at the top of your file:

```elm
import Combinators exposing (..)
```

You can also just import specific combinators such as the K and P combinators for example:

```elm
import Combinators exposing (k, p)
```

## Development

### Formatting

```sh
npx elm-format . --yes
```

### Linting

```sh
npx elm-review .
```
