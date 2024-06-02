# Typst FCFM

> Typst es software relativamente nuevo que está creciendo muy rápidamente.
> Por lo tanto, no puedo asegurar retrocompatibilidad entre versiones del template.

Template de Typst para documentos de la FCFM (auxiliares, controles, pautas)

Puedes ver un ejemplo de documento en [example.pdf](example.pdf).

## Ejemplo de uso

```typ
#import "template/conf.typ": conf

#show: conf.with(
  titulo: "Auxiliar 1",
  subtitulo: "Typst",
  titulo-extra: (
    [*Profesora:* Ada Lovelace],
    [*Auxiliares:* Grace Hopper y Alan Turing],
  ),
  departamento: "dcc",
  curso: "CC4034 - Composición de documentos",
)

...el resto del documento comienza acá
```

Puedes ver un ejemplo más completo en [example.typ](example.typ). Para aprender la sintáxis de Typst existe la [documentación oficial](https://typst.app/docs).

## Parámetros de configuración

La función `conf` importada desde el template recibe los siguientes parámetros:

| Parámetro      | Descripción                                                                                                                                          |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `titulo`       | Título del documento                                                                                                                                 |
| `subtitulo`    | Subtítulo del documento                                                                                                                              |
| `titulo-extra` | Arreglo con bloques de contenido adicionales a agregar después del título. Útil para mostrar los nombres del equipo docente.                         |
| `departamento` | Sigla del departamento asociado al documento. <br> Opciones soportadas: <br> `adh, das, dcc, dfi, dgf, dic, die, dii, dim, dimec, dimin, diqbm, geo` |
| `curso`        | Código y/o nombre del curso.                                                                                                                         |
| `fuente`       | Fuente del documento. Por defecto se usa la de Typst, que es "Linux Libertine". Para usar la de LaTeX, escoger "New Computer Modern".                |

## Cómo usar en la aplicación web

Puedes usar el template en la aplicación web oficial de Typst, que es parecida a Overleaf permitiendo compilar en el navegador y colaborar.

1. Crea una cuenta en [typst.app](https://typst.app) o inicia sesión si ya tienes.
2. Abre el siguiente enlace: [https://typst.app/project/rEkvI_3EvV9aP6LlmEJ3BZ](https://typst.app/project/rEkvI_3EvV9aP6LlmEJ3BZ).
3. Ve al dashboard y verás el template en "Shared with me". Ahí puedes usar el botón de "Duplicate" para crear una copia propia y luego trabajar en ella.

## Cómo usar de forma local

Además, como es open source, puedes [instalar Typst CLI](https://github.com/typst/typst#installation) en tu computador, clonar el repositorio y trabajar de manera local
en algún editor. Adicionalmente, puedes instalar un [LSP](https://github.com/nvarner/typst-lsp).
