// Takes four arguments: the lower bound, the upper bound, the integrand, and the variable of integration. 
// Returns the integral of the integrand from the lower bound to the upper bound with respect to the variable of integration.
#let integ(lower_bound, upper_bound, integrand, variable) = $integral_#lower_bound^#upper_bound #integrand  dif #variable$

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
#let scr(it) = text(
  features: ("ss01",),
  box($cal(it)$),
)

// variance and covariance function
#let var = "Var"
#let cov = "Cov"


// ----- custom math shorthands -----

#import "@preview/quick-maths:0.2.0": shorthands


#let math_shorthands(doc) = {
  show: shorthands.with(
  ($hat(G)$, $hat(#h(0.1em) G #h(0.2em))$),
  ($FF$, $cal(F)$),
  ($AA$, $cal(A)$)
)
  doc
}

// custom operations
#let argmin = math.op("arg min", limits: true)
#let argmax = math.op("arg max", limits: true)

#let rank = math.op("rank")

#let PPP = strong("P")
#let EEE = strong("E")

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
