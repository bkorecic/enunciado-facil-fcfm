#let departamentos = (
  adh: (
    nombre: "Área de Humanidades",
    logo: "adh.svg"
  ),
  das: (
    nombre: "Departamento de Astronomía",
    logo: "das.svg"
  ),
  dcc: (
    nombre: "Departamento de Ciencias de la Computación",
    logo: "dcc.svg"
  ),
  dfi: (
    nombre: "Departamento de Física",
    logo: "dfi.svg"
  ),
  dgf: (
    nombre: "Departamento de Geofísica",
    logo: "dgf.svg"
  ),
  dic: (
    nombre: "Departamento de Ingeniería Civil",
    logo: "dic.svg"
  ),
  die: (
    nombre: "Departamento de Ingeniería Eléctrica",
    logo: "die.svg"
  ),
  dii: (
    nombre: "Departamento de Ingeniería Industrial",
    logo: "dii.svg"
  ),
  dim: (
    nombre: "Departamento de Ingeniería Matemática",
    logo: "dim.svg"
  ),
  dimec: (
    nombre: "Departamento de Ingeniería Mecánica",
    logo: "dimec.svg"
  ),
  dimin: (
    nombre: "Departamento de Ingeniería de Minas",
    logo: "dimin.svg"
  ),
  diqbm: (
    nombre: "Departamento de Ingeniería Química, Biotecnología y Materiales",
    logo: "diqbm.svg"
  ),
  geo: (
    nombre: "Deparamento de Geología",
    logo: "geo.svg"
  )
)

#let conf(
  titulo: none,
  subtitulo: none,
  departamento: "dcc",
  titulo-extra: none,
  curso: "",
  fuente: "",
  doc,
) = {
  set text(lang: "es", font: fuente)
  // Formato de headings. Por defecto (P1., P2., etc)
  set heading(numbering: "P1.")

  if departamento not in departamentos {
    let valid-opts = departamentos.keys().join(", ")
    panic("parámetro departamento debe ser una de las siguientes opciones: " + valid-opts)
  }
  if titulo-extra != none {
    if type(titulo-extra) != array {
      panic("parámetro titulo-extra debe ser una lista")
    }
    for elem in titulo-extra {
      if type(elem) != content {
        panic("titulo-extra debe ser una lista con elementos de tipo content")
      }
    }
  }

  let header = [
    #stack(dir: ltr,
      // El primer elemento del header es el texto, apilado usando un stack.
      align(bottom+left, stack(dir: ttb, spacing: 3pt, "Facultad de Ciencias Físicas y Matemáticas",
          departamentos.at(departamento).nombre,
          curso
      )),
      // Acá va el logo.
      align(bottom+right, box(height: 50pt, image("logos/"+ departamentos.at(departamento).logo)))
    )
    #v(-5pt)
    #line(length: 100%, stroke: 0.4pt)
  ]

  let title = align(center)[
    #grid(row-gutter: 11pt,
      text(22pt, titulo),
      subtitulo
    )
    #if titulo-extra != none {
      grid(row-gutter: 5pt,
        ..titulo-extra
      )
    }
  ]

  // Configuración del tamaño de página, márgenes y header
  // Usamos "context" para que el valor sea reactivo y podamos usar measure
  let header-sep = 20pt // Separación entre header y contenido
  set page("us-letter", 
    margin: (left: 1in, 
      right: 1in, 
      top: 1in+header-sep, 
      bottom: 1in), 
    header: header, 
    header-ascent: header-sep)
  title
  doc
}
