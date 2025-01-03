#import "preamble.typ": conf
#import "commands.typ": *



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



#set heading(numbering: "1.1")

= Introduction

This is an introduction.

= Section

This is a section with a subsection.

== Subsection

Here we can now write some text. This will be the subsection.

== Another Subsection
#lorem(50)

#lorem(50)

= Maths

We can use math commands specified in `commands.typ` by 
$
hat(f)( xi) = integ(-oo, oo, f(x) e^(-2 pi i xi x), x).  
$
Note that here we used the custom `integ` command. 

= Theorems and Proofs

TBD