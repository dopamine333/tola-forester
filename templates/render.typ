// templates/render.typ — turns one tree into a complete HTML page, laid out
// like a Forester site: a « Home link, the tree, its back matter (References,
// Context, Backlinks, Related, Contributions) and, beside it on wide
// screens, a table of contents of the trees it transcludes. Also writes the
// 404 page and forest.json, the search index read by assets/scripts/forest.js.

#import "@tola/address:0.0.0": asset-url, output-url, route-url
#import "@tola/document:0.0.0": current-document, references
#import "@tola/site:0.0.0": site
#import "@tola/web:0.0.0": head-metadata
#import "/templates/model.typ": route-of, site-trees, tree-entry
#import "/templates/tree.typ": (
  cap, metadata-line, slug, taxon-attrs, taxon-label, title-of, to-string, tree-h1,
)

/// <head> entries shared by every page.
#let head-entries(title) = (
  head-metadata(site, title: title)
    + (
      html.meta(name: "forest-manifest", content: output-url("forest.json")),
      html.link(rel: "stylesheet", href: asset-url("/styles/style.css")),
      html.script("", src: asset-url("/scripts/forest.js"), defer: true),
    )
)

/// The page frame: the « Home link (hidden on the root tree) over `body`.
#let shell(body, home: false) = html.div(id: "main-wrapper")[
  #html.header(class: "header")[
    #html.nav(id: "home-link", class: if home { "nav hidden" } else { "nav" })[
      #html.div(class: "logo")[#html.a(href: route-url("/"), title: "home")[« Home]]
    ]
  ]
  #html.main(id: "grid-wrapper", body)
]

// ---- Back matter ----

/// `refs` minus those written inside `regions` (same filters as `refs`).
#let outside(refs, regions, ..filters) = {
  let inside = references(from-within: regions, ..filters).map(r => r.element.location())
  refs.filter(r => r.element.location() not in inside)
}

/// The tree entries whose `output` is `end(r)` for some reference `r` in
/// `refs`, once each, in first-seen order, leaving out `self` (an output).
#let entries-at(refs, end, self) = {
  let trees = site-trees()
  let found = ()
  for r in refs {
    let output = end(r)
    if output == none or output == self or found.any(t => t.output == output) { continue }
    let t = trees.find(t => t.output == output)
    if t != none { found.push(t) }
  }
  found
}

/// One back-matter entry: the tree's heading and metadata over its folded body.
#let backmatter-tree(t) = html.elem("section", attrs: taxon-attrs(t, (class: "block")))[
  #html.header[
    #tree-h1(t, taxon-label(t.taxon), slug(t))
    #metadata-line(t)
  ]
  #html.div(class: "mainmatter collapsed")[#include t.file]
]

/// One back-matter section, or nothing when `trees` is empty.
#let back-section(title, trees) = if trees.len() > 0 {
  html.section(class: "block")[
    #html.header[
      #html.h1[#html.span(class: "taxon")[]#title]
      #html.div(class: "metadata")[#html.ul[]]
    ]
    #html.div(class: "mainmatter")[#for t in trees { backmatter-tree(t) }]
  ]
}

/// The back matter of tree `t`, as in Forester:
/// - References: the Reference trees it (or a tree it transcludes) links to.
/// - Context: the trees transcluding it directly.
/// - Backlinks: the trees linking to it.
/// - Related: the other trees it links to.
/// - Contributions: for a Person tree, the trees naming it author or contributor.
/// Links inside a transclusion belong to the transcluded tree, and the back
/// matter (`<bm>`) and table of contents (`<toc>`) never count.
#let backmatter(t) = context {
  let nested = selector(<tx-head>).or(<tx-body>).or(<bm>).or(<toc>)
  let target = r => if r.target == none { none } else { r.target.output }
  let source = r => r.document.output
  let is-reference = p => p.taxon != none and lower(p.taxon) == "reference"
  let own = entries-at(outside(references(from: auto), nested, from: auto), target, t.output)
  let cited = entries-at(
    outside(references(from: auto), selector(<tx-slug>).or(<bm>).or(<toc>), from: auto),
    target,
    t.output,
  )
  let embedding = outside(references(to: auto, from-within: <tx-slug>), selector(<tx-body>).or(<bm>).or(<toc>), to: auto)
  let contributions = site-trees()
    .filter(p => p.addr != t.addr and (t.addr in p.author or t.addr in p.contributor))
    .sorted(key: p => p.date.at(0, default: datetime(year: 1, month: 1, day: 1)))
    .rev()
  [#html.footer({
    back-section("References", cited.filter(is-reference))
    back-section("Context", entries-at(embedding, source, t.output))
    back-section("Backlinks", entries-at(outside(references(to: auto), nested, to: auto), source, t.output))
    back-section("Related", own.filter(p => not is-reference(p)))
    back-section("Contributions", contributions)
  }) <bm>]
}

// ---- Table of contents ----

/// Nested `<ul>` of the transclusion tree `nodes` ((node:, children:) pairs).
#let toc-list(nodes) = html.ul(class: "block")[#for n in nodes {
  let v = n.node
  html.elem("li", attrs: if v.numbered { (class: "numbered") } else { (:) }, {
    html.a(class: "bullet", href: route-url(route-of(v.addr)), title: to-string(v.title) + "[" + v.addr + "]")[■]
    html.elem("span", attrs: (class: "link local", data-target: "#" + v.id))[
      #taxon-label(v.taxon, numbered: v.numbered)#v.title
    ]
    if n.children.len() > 0 { toc-list(n.children) }
  })
}]

/// The table of contents of this page: every tree transcluded into it,
/// nested as transcluded, read from the `<tx-open>` / `<tx-close>` markers
/// `transclude` writes (those inside the back matter left out). Nothing when
/// the tree transcludes nothing.
#let toc() = context {
  let doc = current-document().location
  let marks = selector(<tx-open>).or(<tx-close>)
  let skip = query(marks.within(doc).within(<bm>)).map(m => m.location())
  let stack = ((children: ()),)
  for m in query(marks.within(doc)) {
    if m.location() in skip { continue }
    if m.value != none {
      stack.push((node: m.value, children: ()))
    } else if stack.len() > 1 {
      let done = stack.pop()
      stack.at(-1).children.push(done)
    }
  }
  let nodes = stack.first().children
  if nodes.len() > 0 {
    [#html.nav(id: "toc")[#html.div(class: "block")[
      #html.h1[Table of Contents]
      #toc-list(nodes)
    ]] <toc>]
  }
}

// ---- Documents ----

/// Whether math content holds something taller than a line (a fraction, a
/// matrix, …), around which delimiters should grow.
#let tall(c) = {
  if type(c) == array { return c.any(tall) }
  if type(c) != content { return false }
  if c.func() in (math.frac, math.binom, math.vec, math.mat, math.cases) { return true }
  c.fields().values().any(tall)
}

/// Chrome lays out stretchy MathML fences with gaps in math fonts
/// ("Sub ( A )"), so paired delimiters around flat content are left unpaired,
/// which Typst writes as non-stretchy `<mo>`s; around tall content they still
/// stretch.
#let flat-fences(it) = if tall(it.body) { it } else { it.body }

/// Render one `(source:, entry:)` record from `select-trees` to its page.
#let render-tree(tree) = {
  let t = tree.entry
  let title = to-string(title-of(t))
  let authors = t.author.map(a => { let p = tree-entry(a); if p == none { a } else { to-string(title-of(p)) } })
  document(t.output, format: "html", title: title, author: authors)[
    #show math.lr: flat-fences
    #html.html(lang: site.language.tag)[
      #html.head(head-entries(title).join())
      #html.body[
        #shell(home: t.addr == "index", {
          html.article({
            html.elem("section", attrs: taxon-attrs(t, (class: "block")))[
              #html.header[
                #tree-h1(t, taxon-label(t.taxon), slug(t))
                #metadata-line(t)
              ]
              #html.div(class: "mainmatter")[#include tree.source.file]
            ]
            backmatter(t)
          })
          toc()
        })
      ]
    ]
  ]
}

/// The 404.html page, for addresses the site does not publish.
#let render-not-found() = document("404.html", format: "html", title: "Page not found")[
  #html.html(lang: site.language.tag)[
    #html.head(head-entries("Page not found").join())
    #html.body[
      #shell(html.article(html.section(class: "block")[
        #html.header[#html.h1[#html.span(class: "taxon")[]Page not found]]
        #html.div(class: "mainmatter")[The page you requested could not be found.]
      ]))
    ]
  ]
]

/// forest.json: every tree's address, title, taxon and URL, for the search box.
#let render-manifest(trees) = asset("forest.json", bytes(json.encode(trees.map(tree => {
  let t = tree.entry
  (addr: t.addr, title: to-string(title-of(t)), taxon: if t.taxon == none { none } else { cap(t.taxon) }, url: route-url(t.permalink))
}))))
