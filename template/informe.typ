#import "base.typ": *
#import "util.typ": *

#let portada1(
  titulo: "",
  subtitulo: "",
  tema: "",
  organizacion: (),
  miembros: (:),
  logo: none,
  fechas: (:),
  lugar: none,
  base-header: base-header,
  base-footer: base-footer,
) = {
  let header = base-header[
    #for nombre in organizacion.slice(0, 3) [#nombre \ ]
  ][
    #if logo != none {image(logo, height: 50pt)}
  ]

  style(styles => {
    let header-height = measure(header, styles).height
  })


  let member-table-args = ()
  for (categoria, nombres) in miembros {
    member-table-args.push[#categoria:]
    member-table-args.push[
      #if type(nombres) in "array" {
        for nombre in nombres [#nombre \ ]
      } else {
        nombres
      }
    ]
  }
  
  base-front-page((header: header))[
    #v(1fr)
    #align(center)[
      #set text(size: 25pt)
      #titulo \
      #subtitulo \
      #tema
    ]
    #v(1fr)

    #grid(columns: (1fr, auto), rows: auto)[][
      #grid(columns: 2, rows: auto, row-gutter: 10pt, column-gutter: 5pt, ..member-table-args)
  
      #for (nombre, fecha) in fechas [
        Fecha de #nombre: #fecha \
      ]
      #lugar
    ]
  ]
}

#let resumen(body) = [
  #heading(level: 1, numbering: none)[Resumen] <header-do-not-display>
  #body
  #pagebreak()
]

#let abstract = resumen

#let indice-text-base1(type, body) = {
  set text(weight: "bold")
  if type == "page" {
    set align(right)
    body
  } else {
    body
  }
}

#let indice1(
  tipo,
  target,
  profundidad: 4,
  numbering-padding: 1em,
  page-padding: 0.3em,
  v-margins: (1em, 0.4em),
  bases: (indice-text-base1, base-indice),
  fillings: ([], repeat[.]),
) = {
  heading(numbering: none)[Índice de #tipo]
  locate(loc => {
    style(styles => {
      let sel = {
        if target == heading {
          target.where(level: 1)
        } else {
          target
        }
      }
      let contents = query(selector(sel).after(loc), loc)
      let index-structs = index-structure-rec(loc, contents, target, 0, profundidad)

      let page-width = calc.max(0pt, ..index-struct-map(index-structs, struct => measure(struct.page, styles).width)) + page-padding

      let grid-maker(structs, depth) = {
        let base = bases.at(depth, default: bases.at(bases.len() - 1, default: (type, body) => body))
        let filling = fillings.at(depth, default: fillings.at(fillings.len() - 1, default: []))
        let v-margin = v-margins.at(depth+1, default: v-margins.at(v-margins.len() - 1, default: 0.3em)) 

        let numbering-width = calc.max(0pt, ..structs.map(struct => measure(struct.numbering, styles).width)) + numbering-padding

        structs.map(struct => {
          let linked-content = (
            base("numbering", struct.numbering),
            base("main", struct.main),
          )

          let content = (
            link(struct.content.location())[
                #if struct.numbering != none {
                  box[
                    #box(width: numbering-width)[
                      #linked-content.at(0)
                    ]
                    #linked-content.at(1)
                  ]
                  //grid(columns: (numbering-width, auto), ..linked-content)
                } else {
                  linked-content.at(1)
                }
            ],
            base("filling", filling),
            base("page", struct.page),
          )

          let grid-args = (grid(columns: (auto, 1fr, page-width), ..content),)
          if struct.children != () and (profundidad == none or depth + 1 < profundidad) {
            grid-args.push[
              #grid(columns: (numbering-width, 1fr))[][
                #grid(columns: 1fr, row-gutter: v-margin, ..grid-maker(struct.children, depth + 1))
              ]
            ]
          }

          grid(columns: 1fr, row-gutter: v-margin, ..grid-args)
        })
      }
      let v-margin = v-margins.at(0, default: v-margins.at(v-margins.len() - 1, default: 0.3em)) 
      grid(columns: 1fr, row-gutter: v-margin, ..grid-maker(index-structs, 0))
    })
  })
}

#let indice-de-contenidos(indice: indice1) = indice1("Contenidos", heading)

#let table-of-contents = indice-de-contenidos

#let header1(base-header) = base-header[
  #locate(loc => {
    let prev-headings = query(selector(heading.where(level: 1)).before(loc), loc)
    let post-headings = query(selector(heading.where(level: 1)).after(loc), loc)
    let heading-found = none
    if post-headings != () and post-headings.first().location().page() == loc.page() {
      heading-found = post-headings.first()
    } else if prev-headings != () {
      heading-found = prev-headings.last()
    }
    if heading-found != none and not (heading-found.has("label") and heading-found.label == label("header-do-not-display")) {
      heading-found.body
    }
  })
][
  #counter(page).display("1")
]

#let footer1(
  titulo,
  curso,
  base-footer
) = {
  set text(style: "italic")
  base-footer[#titulo][#curso]
}
