// Takes four arguments: the lower bound, the upper bound, the integrand, and the variable of integration. 
// Returns the integral of the integrand from the lower bound to the upper bound with respect to the variable of integration.
#let integ(lower_bound, upper_bound, integrand, variable) = $integral_#lower_bound^#upper_bound #integrand space upright(d) #variable$

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


// ----- custom math shorthands -----

#import "@preview/quick-maths:0.2.0": shorthands


#let math_shorthands(doc) = {
  show: shorthands.with(
  ($hat(G)$, $hat(#h(0.1em) G #h(0.2em))$)
)
  doc
}