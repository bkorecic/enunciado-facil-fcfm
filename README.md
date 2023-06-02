# typst-fcfm

Template de Typst para documentos de la FCFM (auxiliares, controles, pautas)

Puedes ver un ejemplo de documento en [example.pdf](example.pdf).

## Ejemplo de uso

```typ
#import "template/conf.typ": conf

#show: doc => conf(
  titulo: "Auxiliar 1",
  subtitulo: "Typst",
  departamento: "dcc",
  profesores: ("Profesor 1", "Profesor 2"),
  auxiliares: ("Auxiliar 1", "Auxiliar 2"),
  curso: "CC4034 - Composición de documentos",
  doc,
)

...el resto del documento comienza acá
```

Puedes ver un ejemplo más completo en [example.typ](example.typ).
