// Workaround for caligraphic font in "Fira Math"
#let math_cal_old = math.cal
#let cal(it) = {
  show math.equation: set text(font: "New Computer Modern Math")
  $#math_cal_old(it)$
}

// Workaround for bb(1) in "Fira Math"
#let math_bb_old = math.bb
#let bb(it) = {
  show math.equation: set text(font: "New Computer Modern Math")
  $#math_bb_old(it)$
}



// TBD
#let rmat(n,m,rule) = {
  let n = int(n.text)
  let m = int(m.text)
  
  let data = ()
  let i = 1
  while i < n {
    let j = 1
    let row = ()
    while j < m {
      row.push(eval(rule, mode: "code", scope: (i: i, j: j)))
      j = j + 1
    }
    data.push(row)
    i = i + 1
  }

  let matrix = math.mat(..data)

  $ #matrix $ 
}



// custom scr font
// 
// 𝒜 ℬ 𝒞 𝒟 ℰ ℱ 𝒢 ℋ ℐ 𝒥 𝒦 ℒ ℳ 𝒩 𝒪 𝒫 𝒬 ℛ 𝒮 𝒯 𝒰 𝒱 𝒲 𝒳 𝒴 𝒵
// 
// 𝒶 𝒷 𝒸 𝒹 ℯ 𝒻 ℊ 𝒽 𝒾 𝒿 𝓀 𝓁 𝓂 𝓃 ℴ 𝓅 𝓆 𝓇 𝓈 𝓉 𝓊 𝓋 𝓌 𝓍 𝓎 𝓏
/* Finally not necessary anymore
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)
*/




#let show-commands(doc) = {
  show sym.lt.eq: sym.lt.eq.slant
  show sym.gt.eq: sym.gt.eq.slant

  doc
}




// general

#let CA = math.cal("A")
#let CB = math.cal("B")
#let CCC = math.cal("C")
#let CD = math.cal("D")
#let CE = math.cal("E")
#let CF = math.cal("F")
#let CG = math.cal("G")
#let CH = math.cal("H")
#let CI = math.cal("I")
#let CJ = math.cal("J")
#let CK = math.cal("K")
#let CL = math.cal("L")
#let CM = math.cal("M")
#let CN = math.cal("N")
#let CO = math.cal("O")
#let CP = math.cal("P")
#let CQ = math.cal("Q")
#let CR = math.cal("R")
#let CS = math.cal("S")
#let CT = math.cal("T")
#let CU = math.cal("U")
#let CV = math.cal("V")
#let CW = math.cal("W")
#let CX = math.cal("X")
#let CY = math.cal("Y")
#let CZ = math.cal("Z")


#let Im = math.op("Im")
#let Re = math.op("Re")

// probability and statistics funcitons
#let var = math.op("Var")
#let Var = var
#let cov = math.op("Cov")
#let Cov = cov
#let bias = math.op("bias")
#let MSE = math.op("MSE")


// distributions 
#let Pois = math.op("Pois")
#let Exp = math.op("Exp")
#let Geom = math.op("Geom")
#let Bin = math.op("Bin")
#let Ber = math.op("Bernoulli")


// custom operations
#let argmin = math.op("arg min", limits: true)
#let argmax = math.op("arg max", limits: true)

#let ind(x) = $bb(1)_(#x)$

#let rank = math.op("rank")

#let PPP = strong("P")
#let EEE = strong("E")

#let Mat = "Mat"
#let GL = "GL"
#let gl = math.frak("gl")
#let SL = "SL"
#let sl = math.frak("sl")
#let PSL = "PSL"
#let SO = "SO"
#let so = math.frak("so")
#let SU = "SU"
#let Un = "U"
#let Or = "O"

#let rc = $#h(0em)\\#h(0em)$
#let lc = $\/$


#let vphi = math.phi.alt


#let stab = math.op("Stab")
#let sign = math.op("sign")

#let Hom = math.op("Hom")
#let End = math.op("End")

#let rad = math.op("rad")

#let supp = math.op("supp")

#let nsg = math.lt.tri

#let opl = math.plus.o
#let bopl = math.plus.o.big

#let cap = math.inter
#let bcap = math.inter.big

#let cup = math.union
#let bcup = math.union.big

#let tensor = math.times.o

#let pm = math.plus.minus
#let mp = math.minus.plus

#let isoto = box(math.arrow.long + place($space^tilde$, dx: 0.05em, dy: -0.75em))

#let injto = math.arrow.hook






#let diag(..args) = {
  args = args.pos()
  let n = args.len()
  let data = ()
  for i in range(n) {
    let row = ()
    for j in range(n) {
      if i == j {
        row.push(args.at(i))
      } else {
        row.push([])
      }
    }
    data.push(row)
  }
  math.mat(..data)
}


//#let red = highlight.with(fill: rgb("#ff373796"), extent: 2pt)
#let red(content) = box(
  fill: rgb("#a61212"), 
  outset: 3pt,
  text(
    fill: white,
    strong(content)
  ))

#let red(content) = {
  set text(
    fill: rgb("#ff0000"),
    weight: "bold"
    )
  content
}



#let ip(left, right) = $lr(angle.l #left, #right angle.r, size: #90%)$

// function to create a note with the lecture date on the right margin
#let lecture_date(date) = {
  place(
    right,
    // Adjust dx to shift the note to the right margin.
    dx: 1cm,
    dy: -1cm,
    // Use a block to ensure the note’s content is set independently.
    block(
      rotate(90deg, origin: center, reflow: true)[
        #smallcaps(date)
      ]
    )
  )
}
