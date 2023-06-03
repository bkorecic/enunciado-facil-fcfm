#import "base.typ": *

#let portada1(
  titulo: "",
  subtitulo: "",
  tema: "",
  organizacion: (),
  miembros: (:),
  logo: none,
  fechas: (:),
  lugar: none,
  page-extra: (:),
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
  
  page(header: header, ..page-extra)[
    #v(1fr)
    #align(center)[
      #set text(size: 25pt)
      #titulo \
      #subtitulo \
      #tema
    ]
    #v(1fr)

    #grid(columns: (1fr, auto), rows: auto)[][
      #table(align: left+top, stroke: 0pt, columns: 2, rows: auto, ..member-table-args)

      #set align(left)
      #for (nombre, fecha) in fechas [
        Fecha de #nombre: #fecha \
      ]
      #lugar
    ]
  ]
}