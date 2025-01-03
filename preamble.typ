#let conf(
  title: none,
  authors: (),
  abstract: [],
  toc: true,
  doc,
) = {

  // specify document margins, paragraph spacing, and text font
  set page(margin: (left: 5cm, right: 5cm, top: 5cm, bottom: 5cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 1.5em, justify: true)
  set text(font: "New Computer Modern", size: 12pt)

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
    
  doc
}