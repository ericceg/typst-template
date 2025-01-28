#import "conf/preamble.typ": *
#import "conf/commands.typ": *


/* ----------------- LOAD PAPER TEMPLATE ----------------- */
#show: paper.with(
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
  institution: [
    Federal Institute of Technology Zurich \
    Department of Mathematics
  ],
  toc: true,
  dark-mode: false
)





/* ----------------- LOAD PROBLEM SHEET TEMPLATE ----------------- 
#show: problem-sheet.with(
  lecture: "Functional Analysis II",
  title: "Problem Sheet 1",
  author: "Eric Ceglie",
  date: "FS 2025",
)
*/

/* ----------------- LOAD CHEATSHEET TEMPLATE -----------------
#show: cheatsheet.with(
  lecture: "Functional Analysis II",
  title: "Problem Sheet 1",
  author: "Eric Ceglie",
  date: "FS 2025",
  dark-mode: true
)
*/


/* ----------------- CUSTOM COLOURS ----------------- */
#let definition = definition.with(fill: rgb("#eefbe9"))
#let theorem = theorem.with(fill: rgb("#faecec"))
#let proposition = proposition.with(fill: rgb("#ffe9ce"))
#let lemma = lemma.with(fill: rgb("#e8dacb"))
#let corollary = corollary.with(fill: rgb("#d8f4f4"))





= Section

This is a section with a subsection.

== Subsection

Here we can now write some text. This will be the subsection.

== Another Subsection
#lorem(50)

#lorem(50)

=== Subsubsection

This is a subsubsection.

=== Another Subsubsection 

This is another subsubsection.

== And Again a Subsection

And again a subsection.




There are also lists like 
- item one
- item two
- item three

and enumerations like 

#set enum(numbering: "(1.a)")

+ first item
+ second item
  + subitem
  + more subitems
+ third item
7. we can also modify the numbers on the fly
+ and the counter will update accordingly

Note that to produce this numbering we put the command `#set enum(numbering: "(1.a)")` in front of the enumeration. 

By using functions we can also set the numbering to be dynamic. For example, we can set the numbering to be the square of the enumeration number by using `#set enum(numbering: n => [(#calc.pow(int(n),2))])`, which yields. 

#set enum(numbering: n => [(#calc.pow(int(n),2))])
+ one 
+ two
+ three
+ four
+ five


= Mathematics 

We can use math commands specified in `commands.typ` by 
$
hat(f)( xi) = integ(-oo, oo, f(x) e^(-2 pi i xi x), x).   
$

Note that here we used the custom `integ` command.


== Block Equations and Numbered Equations


Note that we can individually number specific equations (line by line, thanks to the `equate` package) by using `#<label>` at the end of the line. Every labelled equation will be numbered and can be referenced using `@label`, which yields @label. We may also use `@label[Equation]` which yields @label[Equation]. In the `preamble.typ` file we can also specify a default supplement, but we prefer to have nothing by default.

$
 (integral (x+x^2)/(x^3+x^4)  dif x )^2 (x-1)  x
 &= (x - 1) / x^2 x #<label> \
 &= (1 / x - 1 / x^2) x \
 &= 1 - 1 / x #<eq:1> \
 &= (x-1)/x.
$



= Theorems and Proofs

== Environments

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
    pi(x) := sum_(p <= x) 1 ~x/(log x)
  $<eq:PNT>
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

Proof ideas are also possible.

#proof-idea[
  This is only a sketch of the proof.
]


And it gets even better. Breakable theorems and equations!

#theorem[
  This is a theorem with a very long equation given by $
    (a+b)^2 
    &= a^2 + 2a b + b^2 \
    &= a^2 + 2a b + b^2 #<label1> \
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
    &= a^2 + 2a b + b^2 #<label2> \
    &= a^2 + 2a b + b^2 #<label3> \
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


== More Environments 


#proposition[
  This is a proposition.
]

#lemma[
  This is a lemma.
]

#corollary[
  This is a corollary.
]

#remark[
  This is a remark.
]

#important(title: "Recipe")[
  This is supposed to be used to highlight environments on the fly that have no specific predefined environment but are supposed to be highlighted. The idea here is to call `#important(title: "Recipe")[...]`.
]


= Bibliography and Citations

Citations with bibtex files like `bibliography.bib` are possible. To cite something simply type `@ceglie2024distribution` which yields @ceglie2024distribution. We can also cite with more context by using `@ceglie2024distribution[Theorem 3.7]` which yields @ceglie2024distribution[Theorem 3.7].
We can also cite articles like @zhang2014bounded. 

Note that by passing `full: true` to the `bibliography` command we can show the full bibliography (i.e. include all sources even if some are not cited in the document).


= Commutative Diagrams

Commutative diagrams are also possible!

For example

#align(center)[#commutative-diagram(
  node((0,0), $X$, "X1"),
  node((1,0), $Y$, "Y1"),
  node((0,1), $X$, "X2"),
  node((1,1), $Y$, "Y2"),
  arr("X1", "Y1", $pi$, label-pos: right, "dashed", "surj"),
  arr("Y2", "X2", $phi$, "dashed", "inj"),
  arr("X1", "X2", $f$),
  arr("Y1", "Y2", $f$, label-pos: right),
)]

or

#align(center)[#commutative-diagram(
  node((0, 0), $X$),
  node((0, 1), $Y$),
  node((1, 0), $X \/ "ker"(f)$, "quot"),
  arr($X$, $Y$, $f$),
  arr("quot", (0, 1), $tilde(f)$, label-pos: right, "dashed", "inj"),
  arr($X$, "quot", $pi$),
)]


and much more.


#bibliography("bibliography.bib", full: true)