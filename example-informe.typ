#import "template/conf.typ": informe
#import "template/informe.typ": portada1

#show: informe.with(
  titulo: "Informe 1",
  subtitulo: "Typst",
  tema: "Aprendiendo a usar el template",
  departamento: "dcc",
  autores: ("Integrante1", "Integrante2", "Integrante3"), // content o arreglo de strings
  equipo-docente: ( // diccionario con distintos valores soportados:
    Profesores: ("Profesor1", "Profesor2"), // arreglo de strings
    Auxiliar: "ÚnicoAuxiliar", // un único miembro como string
    Ayudante: [ // bloque de contenido
      Ayudante1 \
      Ayudante $1+1$
    ],
  ),
  curso: "CC4034 - Composición de Documentos",
  fechas: ( // diccionario de fechas, si la portada no soporta
    realización: "1 de Junio de 2023",
    entrega: "Aún en progreso"
  ),
  lugar: "Santiago, Chile",
  portada: portada1, // distintos diseños diposibles (WIP)
)

= Informes con Typst
Parecido a lenguajes como Markdown, puedes escribir para obtener un parrafo, además puedes estilar el texto en *negrita* y _cursiva_.
asdfs
