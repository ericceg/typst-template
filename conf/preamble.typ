#import "@preview/ctheorems:1.1.3": *
#import "@preview/equate:0.2.1": equate
#import "@preview/fletcher:0.5.5": diagram, node, edge
#import "@preview/cheq:0.2.2": checklist
#import "@preview/lilaq:0.3.0" as lq
#import "@preview/itemize:0.1.1" as el

#import "commands.typ": *

// --------------------- GENERAL DOCUMENT SETTINGS ---------------------
#let conf(
  dark-mode: false,
  show-labels: false,
  ref-include-name: true,
  doc
) = {

  /*
  show: el.default-enum-list.with(
    enum-spacing: 1.2em
  ) // (hopefully) temporary fix for the itemize bug (see https://github.com/typst/typst/issues/1204#issuecomment-3140506139)
  */

  // optional dark-mode
  set page(fill: rgb("#32313d")) if dark-mode
  set text(fill: rgb("fdfdfd")) if dark-mode
  set line(stroke: white) if dark-mode // mainly for footnote line to be displayed in the right color when activating dark-mode

  show: equate.with(breakable: true, number-mode: "label")

  show: thmrules.with(qed-symbol: $square$)

  // option to show label (useful while developing the document)
  show: it => {
    if show-labels {

      show heading: it => { 
      if "label" in it.fields() {
        let label_name = "<" + str(it.label) + ">"
        let label_obj = h(-1cm) + text(fill: orange, font: "Fira Code", label_name)
        return(it + place(label_obj) + v(2em))
      } else {
        return it
      }
      } 

      show figure: it => { 
      if "label" in it.fields() {
        let label_name = "<" + str(it.label) + ">"
        let label_obj = text(fill: orange, font: "Fira Code", label_name)
        return(it + place(label_obj, dy: 0em, dx: 1em) + v(2em))
      } else {
        return it
      }
      } 

      it
    }
    else {
      it
    }
  }

  // add name of theorems to references
  show ref: it => {
    if (ref-include-name 
      and it.element != none
      and "caption" in it.element.fields() 
      and it.element.caption != none) {
      link(it.target)[#it (#it.element.caption.body)]
    } else{
      it
    }
  }





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
  // FINALLY FIXED
  set cite(style: "alphanumeric")

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
  show link: set text(fill: blue)
  show ref: set text(fill: blue)


  // better styling for table of contents
  set outline.entry(fill: box(width: 1fr, repeat(h(2pt) + "." + h(2pt))) + h(2pt))
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
            fill: none // remove fill
          ) <modified-entry>])
        }
      }



  // CODE STYLING

  show raw: set text(font: "Fira Code", size: 9pt)
  show raw.where(block: true): set text(size: 7pt)
  //show raw: set text(font: "DejaVu Sans Mono")
  //show raw: set text(font: "Source Code Pro")

  show raw.where(block: true): it => {
    set par.line(
      numbering: n => text(font: "Fira Code", size: 6pt)[#n],
      )
    block(
    width: 100%,
    fill: rgb("#0000000a"),
    // stroke: rgb("#d1d1d1") + 0.8pt,
    stroke: (top: black + 0.5pt, bottom: black + 0.5pt),
    inset: 2mm
    )[#it]
  }

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
  font-text: "New Computer Modern",
  font-math: "New Computer Modern Math",
  cover-image: none,
  show-labels: false,
  doc,
) = {


  
  // load the configuration settings
  show: conf.with(
    dark-mode: dark-mode,
    show-labels: show-labels,
    )


  
  // specify document margins, paragraph spacing, and text font
  set page(margin: (left: 5cm, right: 5cm, top: 6cm, bottom: 7cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 0em, justify: true)
  set text(font: font-text, size: 10pt)

  show math.equation: set text(font: font-math)


  show: it => {
    if chapter-style-heading{
      show heading.where(level:1): it => {
        set text(size: 16pt)
        show math.equation: set text(size: 16pt)
        counter(math.equation).update(0)

        let alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let num = counter(heading).get().at(0)

        let title_prefix = []
        if it.numbering == "A.1"{
          title_prefix = [Appendix #alph.at(num - 1)]
        } else {
          title_prefix = [Chapter #num]
        }
    
        if it.numbering != none {
          [#title_prefix \ #block(it.body + v(1em) )]
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


  if cover-image != none {
    v(1fr)
    set align(center)
    cover-image
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
    set par(leading: 0.8em)
    outline(
        title: heading(outlined: false, bookmarked: true)[Table of Contents], 
        indent: auto,
    )
  }

  pagebreak()

  // set page margins for the main text
  // in general I like the main document to have less margins on the left and right than the title page (mainly for the abstract) and the table of contents
  set page(margin: (left: 3cm, right: 3cm, top: 4cm, bottom: 4cm))

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
  set page(margin: (left: 3cm, right: 3cm, top: 5cm, bottom: 5cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 1.5em, justify: true)
  set text(font: "New Computer Modern", size: 10pt)

  set page(header: grid(
                    columns: (1fr, 1fr, 1fr),
                    align(left)[#author],
                    align(center)[#lecture],
                    align(right)[#smallcaps(university) \ #date]),
  header-ascent: 2em)

  // Draw the title
  {
  set align(center)
  text(20pt, title)
  }
  
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
    set par(leading: 0.8em)
    outline(
        title: [Table of Contents], 
        indent: auto,
    )
  }

  doc
  }







// --------------------- MISC COMMANDS ---------------------


// command to start appendix
// USAGE: 
// add "#show: appendix" where you want the appendix to start
#let appendix(doc) = {

  set math.equation(
    supplement: none,
    numbering: x => {
      numbering("(A.1)", counter(heading).get().first(), x) // numbering will be of the form (SECTION.EQUATION)
    },
  )

  set heading(numbering: "A.1")
  counter(heading).update(0)
  pagebreak()

  doc
}

