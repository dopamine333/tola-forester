// templates/model.typ — what a tree is: the metadata schema every content
// file's `#tola-meta((...))` is checked against, its address and route, and
// the flat tree "entries" the templates work with.
//
// As in Forester, every file under content/ is a tree and its address is its
// file name without `.typ`: content/jc-0001.typ is the tree `jc-0001`,
// published at /jc-0001/. Folders only organize files and never show up in
// addresses or URLs. content/index.typ is the root tree, published at /.

#import "@tola/address:0.0.0": join-route, output-of
#import "@tola/schema:0.0.0": (
  date, non-empty, nullable, one-or-many, optional, schema, trim, try-parse, union,
)
#import "@tola/source:0.0.0": all-sources, parse-sources

#let text-field = union(trim(str), content)

/// Every metadata field a tree may declare; unknown fields are errors.
#let tree-schema = schema((
  title: optional(nullable(text-field), default: none),
  // The kind of tree ("Definition", "Theorem", "Person", "Reference", …),
  // shown before the title. "Person" and "Reference" trees are special: see
  // the back matter in render.typ.
  taxon: optional(nullable(non-empty(trim(str))), default: none),
  // One "YYYY-MM-DD" date or several; each is shown in the metadata line.
  date: optional(one-or-many(date), default: ()),
  // Who wrote it / helped: tree addresses (a "Person" tree, linked by its
  // title) or plain names.
  author: optional(one-or-many(str), default: ()),
  contributor: optional(one-or-many(str), default: ()),
  // Extra metadata line items, mostly for Person and Reference trees.
  position: optional(nullable(text-field), default: none),
  institution: optional(nullable(text-field), default: none),
  venue: optional(nullable(text-field), default: none),
  doi: optional(nullable(non-empty(trim(str))), default: none),
  orcid: optional(nullable(non-empty(trim(str))), default: none),
  external: optional(nullable(non-empty(trim(str))), default: none),
))

/// The address of a source: its file name without `.typ`.
#let address-of(source) = source.filename.slice(0, -4)

/// The route a tree publishes at: / for `index`, /<addr>/ otherwise.
#let route-of(addr) = join-route(if addr == "index" { () } else { (addr,) })

/// A flat tree entry: the validated metadata plus `addr`, `permalink`,
/// `output` and `file` (the source path to `include`).
#let to-entry(source, meta) = {
  let addr = address-of(source)
  let permalink = route-of(addr)
  (..meta, addr: addr, permalink: permalink, output: output-of(permalink), file: source.file)
}

/// The trees to publish, for the root program: validates every source and
/// checks that no two files share an address.
#let select-trees(sources) = {
  let parsed = parse-sources(sources, tree-schema)
  let seen = (:)
  for s in parsed {
    let addr = address-of(s)
    if addr in seen {
      panic("content/" + seen.at(addr) + " and content/" + s.path + " are both the tree \"" + addr + "\"; rename one")
    }
    seen.insert(addr, s.path)
  }
  parsed.map(source => (source: source, entry: to-entry(source, source.meta)))
}

/// Every tree as a flat entry, for lookups. Lenient: a source whose metadata
/// isn't available yet (Tola evaluates sources in rounds) or is invalid is
/// skipped; `select-trees` is what reports errors.
#let site-trees() = {
  all-sources()
    .filter(source => source.meta != none)
    .map(source => (source: source, parsed: try-parse(source.meta, tree-schema)))
    .filter(r => r.parsed.ok)
    .map(r => to-entry(r.source, r.parsed.value))
}

/// The entry of tree `addr`, or `none`.
#let tree-entry(addr) = site-trees().find(t => t.addr == addr)
