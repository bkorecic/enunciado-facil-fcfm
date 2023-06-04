#let index-struct(numbering, main, page, children, content) = (
  numbering: numbering,
  main: main,
  page: page,
  children: children,
  content: content
)

#let index-structure-rec(loc, contents, target, depth, max-depth) = {
  if depth == max-depth { return none }

  contents.map(it => {
    let siguientes-inclusive = query(selector(target).after(it.location()), loc)
    let siguientes = if siguientes-inclusive.len() > 1 {
        siguientes-inclusive.slice(1)
      } else {
        ()
      }
    
    let siguiente-it = siguientes.at(0, default: none)
    let numbering-part = {
      if it.numbering != none {
        numbering(it.numbering, ..counter(heading).at(it.location()))
      } else {
        none
      }
    }

    let main-part = it.body

    let page-part = [#counter(page).at(it.location()).first()]

    let children-part = {
      if siguiente-it != none and target == heading and siguiente-it.level > it.level {
        let siguiente-mismo-nivel = siguientes.position(it2 => it.level == it2.level)
        if siguiente-mismo-nivel == none {
          siguiente-mismo-nivel = siguientes.len()
        }

        let hijos = siguientes.slice(0, siguiente-mismo-nivel).filter(it2 => it2.level == siguiente-it.level)

        index-structure-rec(loc, hijos, target, depth + 1, max-depth)
      } else {
        ()
      }
    }

    index-struct(numbering-part, main-part, page-part, children-part, it)
  })
}

#let index-struct-map(structs, fun) = {
  let ret = ()
  for struct in structs {
    ret.push(fun(struct))
    ret = ret + index-struct-map(struct.children, fun)
  }
  ret
}
