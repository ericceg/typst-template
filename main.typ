#import "conf/preamble.typ": *
#import "conf/commands.typ": *



#show: conf.with(
  title: [
    Template Document
  ],
  authors: (
    (
      name: "Eric Ceglie",
      affiliation: "ETH Zurich",
      email: "eceglie@ethz.ch",
    ),
    (
      name: "Second Author",
      affiliation: "ETH Zurich",
      email: "sauthor@ethz.ch",
    )
  ),
  abstract: [#lorem(50)],
  toc: true,
)





= Introduction

This is an introduction.

= Section

This is a section with a subsection.

== Subsection

Here we can now write some text. This will be the subsection.

== Another Subsection
#lorem(50)

#lorem(50)

= Mathematics

We can use math commands specified in `commands.typ` by 
$
hat(f)( xi) = integ(-oo, oo, f(x) e^(-2 pi i xi x), x).  
$
Note that here we used the custom `integ` command. 

= Theorems and Proofs

We have a lot of custom environments. They are specified in the `preamble.typ` file. 



#definition[
  The Pontryagin dual of a locally compact abelian group $G$ is defined as 
  $ 
  hat(G) &= {chi : G -> TT | "chi is a continuous group homomorphism"}. 
  $
]

#theorem[
  For any LCA group $G$ we have $hat(hat(G)) = G$.
]<pontriagin-duality>

We can label theorems by `<pontriagin-duality>` and then reference them by `@pontriagin-duality`. 

#proof[
  This is supposed to be a proof for @pontriagin-duality. 
]

We can also give custom names to our environments. 

#theorem(title: "Prime Number Theorem", "PNT", supplement: "PNT")[
  We have $
    pi_(q,a)(x) := sum_(p <= x) 1 ~x/(log x)
  $
  as $x -> oo$.
]<PNT>

#proof([of @PNT])[
  This is supposed to be a proof of @PNT[the prime number theorem]. 

  Note that here the name when referenced is given by `suplement: "PNT"` in the theorem declaration. We can also fully customise the name when referencing by `@PNT[Prime Number Theorem]` which yields @PNT[Prime Number Theorem].
]

We have also different styles for say examples.

#example(number: "187")[
  This is example number 187.
]<example-187>

Note that even custom numbering is possible, however referencing it is a bit more cumbersome.
When declaring the example we can pass an argument `number: "187"` which will be used as the number of the example. 
Then we can reference it manually by `#link(<example-187>)[Example 187]` which yields #link(<example-187>)[Example 187].

No numbering at all is also possible.

#example(numbering: none)[
  Example with no number.
]


And it gets even better. Breakable theorems and equations!

#theorem[
  This is a theorem with a very long equation given by $
    (a+b)^2 
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2.  $
]


= Bibliography and Citations

Citations with bibtex files like `bibliography.bib` are possible. To cite something simply type `@ceglie2024distribution` which yields @ceglie2024distribution. We can also cite with more context by using `@ceglie2024distribution[Theorem 3.7]` which yields @ceglie2024distribution[Theorem 3.7].
We can also cite articles like @zhang2014bounded. 

Note that by passing `full: true` to the `bibliography` command we can show the full bibliography (i.e. include all sources even if some are not cited in the document).


#bibliography("bibliography.bib", full: true)