#import "@preview/ctheorems:1.1.3": *

// --------------------- CUSTOM ENVIRONMENTS ---------------------

// custom environments (for theorems, definitions, examples, proofs, etc.)


// set some default settings that should be true for all environments
#let thmbox = thmbox.with(
  breakable: true,    // allow breakable theorems
  radius: 0em,        // no rounded corners when drawing a frames
  inset: 0em,
  separator: [*.*],   // add a period after the theorem number
  base_level: 1,      // always set the base level to 1 (like this there will be only a new base number after a new section, subsections won't change the numbering),
  padding: (top: 0em, bottom: 0em)
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
  breakable: false, 
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


#let conjecture = thmframed(
  "theorem", 
  "Conjecture", 
  titlefmt: x => strong([#emoji.crystal #x]),
  bodyfmt: x => emph(x))



// ----- proof environments ------

#let proof = thmproof(
  "proof", 
  "Proof")



#let proof-idea-env = thmproof(
  "proof", 
  "Proof Idea",
)

#let proof-idea(..args) = {
  show: thmrules.with(qed-symbol: $minus.square$)
  proof-idea-env(..args)
  show: thmrules.with(qed-symbol: $square$)
}



// ----- misc environment ------

#let notation = thmbox(
  "theorem", 
  "Notation",
  titlefmt: x => strong([#x]))

#let warning = thmbox(
  "theorem", 
  "Warning",
  titlefmt: x => strong([#emoji.warning #x]))

#let exercise = thmbox(
  "theorem", 
  "Exercise",
  titlefmt: x => strong([#emoji.pencil #x]))

#let problem = thmbox(
  "theorem", 
  "Problem",
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

#let application = thmbox(
  "theorem", 
  "Application",
  separator: ".",
  namefmt: name => emph([(#name)]),
  titlefmt: x => emph([#emoji.abacus #x]))

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



/* ----------------- CUSTOM COLOURS ----------------- */
#let definition = definition.with(fill: rgb("#eefbe9"))
#let theorem = theorem.with(fill: rgb("#faecec"))
#let proposition = proposition.with(fill: rgb("#ffe9ce"))
#let lemma = lemma.with(fill: rgb("#e8dacb"))
#let corollary = corollary.with(fill: rgb("#d8f4f4"))
#let conjecture = conjecture.with(fill: rgb("#f0e6ff"))



/*
#let proof(..args) = none
#let proof-idea(..args) = none
#let example(..args) = none
*/