// templates/tree.typ — how a tree looks wherever it appears (its own page, a
// transclusion, the back matter), plus the two helpers trees use:
// `transclude` and `tree-link`. The markup mirrors Forester's: a
// `section.block` holding a `header` (taxon, title, `[addr]`, metadata line)
// and a `div.mainmatter` body.
//
// Only native `link`s count as links between trees (`references()` in
// @tola/document). Raw `html.a` is used where a link must not count: author
// names, the table of contents and the « Home link.

#import "@tola/address:0.0.0": route-url
#import "@tola/schema:0.0.0": try-parse
#import "@tola/source:0.0.0": all-sources
#import "@tola/web:0.0.0": plain-text
#import "/templates/model.typ": address-of, route-of, tree-entry, tree-schema

/// Plain text of a string or content (`none` -> "").
#let to-string(it) = if it == none { "" } else if type(it) == str { it } else { plain-text(it) }

/// "definition" -> "Definition".
#let cap(s) = upper(s.first()) + s.slice(1)

/// A date as Forester prints it: "August 13, 2023".
#let fmt-date(d) = d.display("[month repr:long] [day padding:none], [year]")

/// A tree's title for lists, tabs and search: its title, or its address.
#let title-of(t) = if t.title == none { t.addr } else { t.title }

/// Authors or contributors: "A", "A and B", "A, B and C". A name that is the
/// address of a tree (a Person) links to it by title; the link is raw, so it
/// lands in the person's Contributions rather than their Backlinks.
#let people(names) = {
  let shown = names.map(n => {
    let t = tree-entry(n)
    if t == none { n } else { html.a(href: route-url(t.permalink))[#title-of(t)] }
  })
  if shown.len() == 1 { shown.first() } else { shown.slice(0, -1).join(", ") + " and " + shown.last() }
}

/// The metadata line under a title: dates, authors, contributors and the
/// Person / Reference fields, separated by " · " (in CSS).
#let metadata-line(t) = {
  let items = t.date.map(fmt-date)
  if t.author.len() > 0 { items.push(html.elem("address", attrs: (class: "author"), people(t.author))) }
  if t.contributor.len() > 0 {
    items.push(html.elem("address", attrs: (class: "contributor"))[with contributions from #people(t.contributor)])
  }
  for key in ("position", "institution", "venue") {
    if t.at(key) != none { items.push(t.at(key)) }
  }
  if t.doi != none { items.push(html.a(class: "doi", href: "https://doi.org/" + t.doi)[#t.doi]) }
  if t.orcid != none { items.push(html.a(class: "orcid", href: "https://orcid.org/" + t.orcid)[#t.orcid]) }
  if t.external != none { items.push(html.a(class: "external", href: t.external)[#t.external]) }
  html.div(class: "metadata")[#html.ul[#for i in items { html.li(class: "meta-item")[#i] }]]
}

/// The taxon slot in front of a title: "Definition. ", or, in a numbered
/// transclusion, "Definition " and a CSS-counted section number ("1.2. ").
#let taxon-label(taxon, numbered: false) = html.span(class: "taxon")[#if numbered {
  if taxon != none { cap(taxon) + " " }
  html.span(class: "section-number")[]
} else if taxon != none { cap(taxon) + ". " }]

/// The `[addr]` link after a title.
#let slug(t) = html.span(
  class: "slug",
  link(route-url(t.permalink))[\[#t.addr\]]
)
/// A tree's `<h1>`: taxon, title (an untitled tree shows only its address),
/// then the address. Code block, not markup: no stray whitespace.
#let tree-h1(t, taxon, address) = html.h1({
  taxon
  if t.title != none { t.title + [ ] }
  address
})

/// The `data-taxon` attribute Forester's CSS keys on, if the tree has a taxon.
#let taxon-attrs(t, attrs) = if t.taxon == none { attrs } else { (..attrs, data-taxon: cap(t.taxon)) }

/// Link to tree `addr`, like Forester's `[[addr]]`: `#tree-link("jc-0002")`
/// shows its title, `#tree-link("jc-0002")[this note]` your own text.
#let tree-link(addr, ..text) = {
  let t = tree-entry(addr)
  link(
    route-url(route-of(addr)),
    text.pos().at(0, default: if t == none { addr } else { title-of(t) })
  )
}

/// Embed tree `addr` here, like Forester's `\transclude{addr}`: a section with
/// its own heading and metadata whose header folds the body. Options as in
/// Forester: `numbered` (a section number, counted in CSS), `expanded` (start
/// unfolded), `show-metadata` (dates and authors under the title) and
/// `show-heading` (`false` inlines the body with no heading).
///
/// It writes the regions the back matter relies on: the heading is
/// `<tx-head>`, the body `<tx-body>` (its links belong to the embedded tree)
/// and the `[addr]` link `<tx-slug>` (this page is the embedded tree's
/// Context). `<tx-open>` / `<tx-close>` markers feed the table of contents.
/// A tree that ends up embedding itself is a cyclic include, which Typst
/// reports; the include stays outside `context` for that reason.
#let transclude(addr, numbered: true, expanded: true, show-metadata: false, show-heading: true) = {
  let source = all-sources().find(s => address-of(s) == addr)
  assert(source != none, message: "transclude: no tree has the address \"" + addr + "\"")
  let body = include source.file
  if not show-heading { return body }
  // Defaults while Tola is still settling metadata; `select-trees` reports invalid metadata.
  let parsed = try-parse(if source.meta == none { (:) } else { source.meta }, tree-schema)
  let meta = if parsed.ok { parsed.value } else { try-parse((:), tree-schema).value }
  let t = (..meta, addr: addr, permalink: route-of(addr))
  let classes = ("block",) + (if show-metadata { () } else { ("hide-metadata",) }) + (if numbered { ("numbered",) } else { () })
  // A page can show one tree several times (twice transcluded, or again in
  // the back matter), so each section's id carries a running number.
  let sections = counter("transclusion")
  sections.step()
  context {
    let id = "tree-" + addr + "-" + str(sections.get().first())
    [#metadata((addr: addr, id: id, title: title-of(t), taxon: t.taxon, numbered: numbered)) <tx-open>]
    html.elem("section", attrs: taxon-attrs(t, (class: classes.join(" "), id: id)))[
      #[#html.header[
        #tree-h1(t, taxon-label(t.taxon, numbered: numbered), [#slug(t) <tx-slug>])
        #metadata-line(t)
      ] <tx-head>]
      #[#html.div(class: if expanded { "mainmatter" } else { "mainmatter collapsed" })[#body] <tx-body>]
    ]
    [#metadata(none) <tx-close>]
  }
}
