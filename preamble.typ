#let conf(
  title: none,
  authors: (),
  abstract: [],
  toc: true,
  doc,
) = {
  set page(margin: (left: 4cm, right: 4cm, top: 5cm, bottom: 5cm))
  set par(leading: 0.6em, spacing: 1.2em, first-line-indent: 1.5em, justify: true)
  set text(font: "New Computer Modern", size: 12pt)

  show heading: set block(above: 1.2em, below: 1.2em)
  //show link: set text(font: "DejaVu Sans Mono", fill: blue)
  show link: set text(font: "New Computer Modern", fill: blue)


  // Set and show rules from before.
  set align(center)
  text(17pt, title)
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
      #v(2em)
      _#datetime.today().display("[day padding:none]. [month repr:long] [year]")_
    ]),
  )

  v(2em)
  emph(datetime.today().display("[day padding:none]. [month repr:long] [year]"))
  v(2em)

  set align(left)
  
  if abstract != [] {
    v(2em)
    par(justify: false)[
      *Abstract* \
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

  set page(numbering: "1")
  counter(page).update(1)
    
  doc
}