#import "@preview/ctheorems:1.1.3": *
#import "commands.typ": *



#let conf(
  title: none,
  authors: (),
  abstract: [],
  toc: true,
  doc,
) = {

  // load math shorthands from "commands.typ" file
  show: math_shorthands.with()

  // allow breakable equations (long equation blocks automatically break across pages)
  show math.equation: set block(breakable: true)

  // specify document margins, paragraph spacing, and text font
  set page(margin: (left: 5cm, right: 5cm, top: 5cm, bottom: 5cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 1.5em, justify: true)
  set text(font: "New Computer Modern", size: 10pt)

  // specify heading font and spacing
  show heading: set block(above: 1.2em, below: 1.2em)

  // specify link font and color
  // a good alternative font to use is "DejaVu Sans Mono"
  show link: set text(font: "New Computer Modern", fill: blue)


  // Draw the title
  set align(center)
  text(20pt, title)
  v(2em)

  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #smallcaps(author.affiliation) \
      #link("mailto:" + author.email) 
    ]),
  )

  v(2em)
  emph(datetime.today().display("[day padding:none]. [month repr:long] [year]"))
  v(2em)

  set align(left)

  if abstract != [] {
    set align(center)
    [*Abstract*\ ]
    set align(left)
    par(first-line-indent: 0em)[
    #abstract
    ]
  }

  set align(left)

  if toc {
    pagebreak()
    show outline.entry.where(
      level: 1
    ): it => {
      if it.at("label", default: none) == <modified-entry> {
        it // prevent infinite recursion
      } else {
        strong([#outline.entry(
          it.level,
          it.element,
          it.body,
          [],  // remove fill
          it.page  // remove page number
        ) <modified-entry>])
      }
    }

    outline(
        title: [Table of Contents], 
        indent: auto, 
        fill: box(width: 1fr, repeat(h(2pt) + "." + h(2pt))) + h(2pt),
    )
  }

  pagebreak()

  // set page margins for the main text
  // in general I like the main document to have less margins on the left and right than the title page (mainly for the abstract) and the table of contents
  set page(margin: (left: 3.5cm, right: 3.5cm, top: 5cm, bottom: 5cm))

  set page(numbering: "1")
  counter(page).update(1)
  
  show: thmrules.with(qed-symbol: $square$)

  doc
}


// custom environments (for theorems, definitions, examples, proofs, etc.)


// set some default settings that should be true for all environments
#let thmbox = thmbox.with(
  breakable: true,  // allow breakable theorems
  radius: 0em,      // no rounded corners when drawing a frames
  inset: 0em,
  separator: [*.*]
)


#let definition = thmbox(
  "theorem", 
  "Definition")

#let theorem = thmbox(
  "theorem", 
  "Theorem", 
  inset: (left: 0.6em, right: 0.6em, top: 1em, bottom: 1em),
  padding: (left: -0.6em, right: -0.6em, top: 0em, bottom: 0em),
  bodyfmt: x => emph(x),
  fill: rgb("#e4e4e4"))


#let example = thmbox(
  "theorem", 
  "Example",
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: emph)


#let proof = thmproof(
  "proof", 
  "Proof",
  inset: 0em,
  separator: ".")






