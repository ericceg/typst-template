#import "@preview/ctheorems:1.1.3": *
#import "@preview/equate:0.2.1": equate
#import "@preview/commute:0.2.0": node, arr, commutative-diagram

#import "@preview/cheq:0.2.2": checklist


#import "commands.typ": *

// --------------------- GENERAL DOCUMENT SETTINGS ---------------------
#let conf(
  dark-mode: false,
  doc
) = {

  // optional dark-mode
  set page(fill: rgb("#32313d")) if dark-mode
  set text(fill: rgb("fdfdfd")) if dark-mode
  set line(stroke: white) if dark-mode // mainly for footnote line to be displayed in the right color when activating dark-mode

  show: equate.with(breakable: true, number-mode: "label")

  show: thmrules.with(qed-symbol: $square$)



  // specify numbering rules for equations
  set math.equation(
    supplement: none,
    numbering: x => {
      numbering("(1.1)", counter(heading).get().first(), x) // numbering will be of the form (SECTION.EQUATION)
    },
  )
  // reset equation counter at beginning of each new section with level 1
  show heading.where(level:1): it => {
    counter(math.equation).update(0)
    it
  }

  // disabled checklist as this alters the formatting of normal lists
  //show: checklist

  // automatically put bibliography on separate page
  show bibliography: x => {pagebreak() + x}

  // set default style for citation
  // this would be the desired style, but unfortunately there is still a bug where supplements are not considered in this style. 
  // active issue on GitHub: https://github.com/typst/hayagriva/issues/48
  //set cite(style: "alphanumeric")

  // specify numbering for headings
  set heading(numbering: "1.1")

  // load math shorthands from "commands.typ" file
  show: math_shorthands.with()

  // specify indents for lists and enumerations
  set list(indent: 1.5em)
  set enum(indent: 1.5em)


  // specify heading font and spacing
  show heading: set block(above: 1.2em, below: 1.2em)

  // specify link font and color
  // a good alternative font to use is "DejaVu Sans Mono"
  show link: set text(font: "New Computer Modern", fill: blue)


  doc
}


// --------------------- PAPAER STYLE ---------------------
#let paper(
  title: none,
  authors: (),
  date: none,
  abstract: [],
  institution: [],
  preface: [],
  toc: true,
  dark-mode: false,
  chapter-style-heading: true,
  doc,
) = {
  
  // load the configuration settings
  show: conf.with(dark-mode: dark-mode)


  
  // specify document margins, paragraph spacing, and text font
  set page(margin: (left: 5cm, right: 5cm, top: 6cm, bottom: 7cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 1.5em, justify: true)
  set text(font: "New Computer Modern", size: 10pt)



  show: it => {
    if chapter-style-heading{
      show heading.where(level:1): it => {
        set text(size: 16pt)
        counter(math.equation).update(0)
        if it.numbering != none {
          [Chapter #counter(heading).get().at(0) \ \ #it.body]
        } else {
          it
        }
      } 
      it
    } else {
      it
    }
  }
  

  // automatically begin a new page at each section with level 1 if it is not the very first section
  show heading: x => {
    if x.numbering != none and x.level == 1 and counter(heading).get() != (1,) {
    pagebreak() + x}
    else{
      x
    }}



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


  if abstract != [] {
    v(0.3fr)
    set align(center)
    [*Abstract*\ ]
    set align(left)
    par(first-line-indent: 0em)[
    #abstract
    ]
  }

  v(1fr)
  if date == none {
    emph(datetime.today().display("[day padding:none]. [month repr:long] [year]"))    
  } else {
    emph(date)
  }
  v(1em)

  if institution != [] {
    smallcaps(institution)
  }



  set align(left)

  if preface != [] {
    pagebreak()
    [
      #heading.with(numbering: none, outlined: false)("Preface")
      #preface
    ]
  }

  if toc {
    pagebreak()
    show outline.entry.where(
      level: 1
    ): it => {
      if it.at("label", default: none) == <modified-entry> {
        it // prevent infinite recursion
      } else {
        v(0.5em) // add spacing before each section with level 1
        // make level 1 sections bold
        strong([#outline.entry(
          it.level,
          it.element,
          it.body,
          [],  // remove fill
          it.page  // remove page number
        ) <modified-entry>])
      }
    }

    set par(leading: 0.8em)

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

  doc
}




// --------------------- PROBLEM SHEET STYLE ---------------------
#let problem-sheet(
  lecture: none,
  title: none,
  author: "Eric Ceglie",
  university: "ETH Zurich",
  date: none,
  doc,
) = {

  if date == none{
    date = datetime.today().display("[day padding:none]. [month repr:long] [year]")
  }
  
  // load the configuration settings
  show: conf.with()

  set page(numbering: "1")


  // specify document margins, paragraph spacing, and text font
  set page(margin: (left: 4cm, right: 4cm, top: 5cm, bottom: 5cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 1.5em, justify: true)
  set text(font: "New Computer Modern", size: 10pt)

  set page(header: grid(
                    columns: (1fr, 1fr, 1fr),
                    align(left)[#author],
                    align(center)[#lecture],
                    align(right)[#smallcaps(university) \ #date]),
  header-ascent: 2em)

  // Draw the title
  set align(center)
  text(20pt, title)

  set align(left)

  doc
  }



// --------------------- CHEATSHEET STYLE ---------------------
#let cheatsheet(
  lecture: none,
  title: none,
  author: "Eric Ceglie",
  date: none,
  dark-mode: false,
  toc: false,
  doc,
) = {


  // load the configuration settings
  show: conf.with(dark-mode: dark-mode)

  set page(flipped: true, columns: 3)
  show: set columns(gutter: 2em)

  if date == none{
    date = datetime.today().display("[day padding:none]. [month repr:long] [year]")
  }

  set page(numbering: "1")


  // specify document margins, paragraph spacing, and text font
  set page(margin: (left: 0.4cm, right: 0.4cm, top: 1cm, bottom: 0.4cm))
  set par(leading: 0.3em, spacing: 0.6em, first-line-indent: 0em, justify: true)
  set text(font: "New Computer Modern", size: 8pt)

  set page(header: grid(
                    columns: (1fr, 1fr, 1fr),
                    align(left)[#author],
                    align(center)[#lecture],
                    align(right)[#date]),
  header-ascent: 0.4cm)


  // automatically begin a new page at each section with level 1 if it is not the very first section
  show heading: x => {
    if x.numbering != none and x.level == 1 and (counter(heading).get() != (1,) or toc) {
    line(length: 100%, stroke: rgb("#7f7f7f")) + x}
    else{
      x
    }}



  // Draw the title
  {
  set align(center)
  text(20pt, title)
  }

  set align(left)

  if toc {
    show outline.entry.where(
      level: 1
    ): it => {
      if it.at("label", default: none) == <modified-entry> {
        it // prevent infinite recursion
      } else {
        v(0.5em) // add spacing before each section with level 1
        // make level 1 sections bold
        strong([#outline.entry(
          it.level,
          it.element,
          it.body,
          [],  // remove fill
          it.page  // remove page number
        ) <modified-entry>])
      }
    }
    set par(leading: 0.8em)
    outline(
        title: [Table of Contents], 
        indent: auto,
        fill: box(width: 1fr, repeat(h(2pt) + "." + h(2pt))) + h(2pt),
    )

  }

  doc
  }






// --------------------- CUSTOM ENVIRONMENTS ---------------------

// custom environments (for theorems, definitions, examples, proofs, etc.)


// set some default settings that should be true for all environments
#let thmbox = thmbox.with(
  breakable: true,    // allow breakable theorems
  radius: 0em,        // no rounded corners when drawing a frames
  inset: 0em,
  separator: [*.*],   // add a period after the theorem number
  base_level: 1,      // always set the base level to 1 (like this there will be only a new base number after a new section, subsections won't change the numbering)
)


#let thmproof = thmproof.with(
  breakable: true,    // allow breakable proofs
  inset: 0em,
  separator: [.],   // add a period after the proof
)



// define a function for framed theorems. here the style of the frame can be customized
#let thmframed = thmbox.with(
  inset: (left: 0.6em, right: 0.6em, top: 0.8em, bottom: 1em),
  padding: (left: -0.6em, right: -0.6em, top: 0em, bottom: 0em),
)



// ----- definition environment ------
#let definition = thmframed(
  "theorem", 
  "Definition",
  titlefmt: x => strong([#emoji.seedling #x]))



// ----- statement environments ------

#let theorem = thmframed(
  "theorem", 
  "Theorem", 
  titlefmt: x => strong([#emoji.fire #x]),
  bodyfmt: x => emph(x))

#let proposition = thmframed(
  "theorem", 
  "Proposition", 
  titlefmt: x => strong([#emoji.yarn #x]),
  bodyfmt: x => emph(x))

#let lemma = thmframed(
  "theorem", 
  "Lemma", 
  titlefmt: x => strong([#emoji.ladder #x]),
  bodyfmt: x => emph(x))

#let corollary = thmframed(
  "theorem", 
  "Corollary", 
  titlefmt: x => strong([#emoji.wave #x]),
  bodyfmt: x => emph(x))


// ----- proof environments ------

#let proof = thmproof(
  "proof", 
  "Proof")



#let proof-idea = thmproof(
  "proof", 
  "Proof Idea",
  bodyfmt: body => [
  #body #h(1fr) $minus.square$ 
  ]
)



// ----- misc environment ------


#let exercise = thmbox(
  "theorem", 
  "Exercise",
  titlefmt: x => strong([#x]))


#let solution = thmbox(
  "theorem", 
  "Solution",
  separator: ".",
  titlefmt: x => emph([#x])).with(numbering: none)


#let example = thmbox(
  "theorem", 
  "Example",
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: x => emph([#emoji.deer #x]))


#let remark = thmbox(
  "theorem", 
  "Remark",
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: x => emph([#emoji.bird #x]))


#let important = thmbox(
  "theorem", 
  "Important",
  separator: ".",
  namefmt: name => smallcaps([(#name)]),
  titlefmt: x => smallcaps([#x]))






