#let base-header(left-body, right-body) = {
  set block(spacing: 0pt, clip: false)
  set par(leading: 0.4em)
  grid(columns: (auto, 1fr), rows: auto)[
    #set align(left + bottom)
    #left-body
  ][
    #set align(right + bottom)
    #right-body
  ]
  v(8pt)
  line(length: 100%, stroke: 0.4pt)
}

#let base-footer(left-body, right-body) = {
  set block(spacing: 0pt, clip: false)
  set par(leading: 0.4em)
  line(length: 100%, stroke: 0.4pt)
  v(8pt)
  grid(columns: (auto, 1fr), rows: auto)[
    #set align(left + top)
    #left-body
  ][
    #set align(right + top)
    #right-body
  ]
}

#let base-table-of-contents(body) = [
  #body
]

#let base-front-page(page-args, body) = {
  page(..page-args)[
    #body
    #counter(page).update(0) // Limitación de Typst https://typst.app/docs/reference/meta/counter/#methods-step
  ]
}

#let base-indice(type, body) = {
  set text(weight: "regular")
  if type == "page" {
    set align(right)
    body
  } else {
    body
  } 
}
