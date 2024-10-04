#import "departamentos.typ" as departamentos


// Función para aplicar el template a un documento
//
// - titulo (string): Título del documento
// - subtitulo (string): Subtítulo del documento
// - departamento (dictionary): Departamento asociado al documento
// - titulo-extra (array): Arreglo de contenido para agregar después del subtítulo. Útil para poner el equipo docente.
// - curso: (string): Nombre del curso asociado al documento
// - doc (content): Documento para aplicar el template
// -> content
#let conf(
  titulo: none,
  subtitulo: none,
  titulo-extra: none,
  departamento: departamentos.dcc,
  curso: "",
  doc,
) = {
  set text(lang: "es")
  // Formato de headings. Por defecto (P1., P2., etc)
  set heading(numbering: "P1.")

  // Chequeo de tipos para departamento
  if type(departamento) != dictionary {
    panic("parámetro departamento debe ser un diccionario")
  }
  if not "nombre" in departamento {
    panic("parámetro departamento es diccionario pero no tiene llave 'nombre'")
  }
  if not "logo" in departamento {
    panic("parámetro departamento es diccionario pero no tiene llave 'logo'")
  }

  // Chequeo de tipos para titulo-extra
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
          departamento.nombre,
          curso
      )),
      // Acá va el logo.
      align(bottom+right, departamento.logo)
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
  let header-sep = 20pt // Separación entre header y contenido
  set page("us-letter", 
    margin: (left: 1in, 
      right: 1in, 
      top: 1in+header-sep, 
      bottom: 1in), 
    header: header, 
    header-ascent: header-sep)

  // La función retorna el título generado seguido del resto
  // del documento
  title
  doc
}
