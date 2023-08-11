#let rep(padding: 0pt, count: auto, body) = layout(size => {style(styles => {
  let width = measure(body, styles).width
  
  let content = pad(right: padding, body)
  
  let count-real = if count != auto {
    count
  } else {
    calc.quo((size.width - width).pt(), (width + padding).pt())
  }

  stack(dir: ltr, spacing: padding, ..range(count-real + 1).map(_ => body))
})})