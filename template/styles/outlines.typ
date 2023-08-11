#let align-pages(it-outline) = locate(loc => style(styles => {
  let width = query(label("my-label"), loc).map(it => measure(it, styles).width).fold(0pt, calc.max)

  show outline.entry: it => {
    if not it.has("label") or it.label != label("show-rule-no-rec") {
      [#outline.entry(
        it.level,
        it.element,
        it.body,
        it.fill,
        box(width: width, [#it.page<my-label>])
      )<show-rule-no-rec>]
    } else {
      it
    }
  }

  it-outline
}))
