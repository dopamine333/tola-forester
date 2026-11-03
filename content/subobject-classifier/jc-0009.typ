#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

For #tree-link("jc-000X")[monomorphisms] $u : U arrow.r.hook A$ and $v : V arrow.r.hook A$, we write $u <= v$ if for every generalized element $x$ of $A$, $x in u$ implies $x in v$. We write $u tilde.op v$ if $u <= v$ and $v <= u$.
