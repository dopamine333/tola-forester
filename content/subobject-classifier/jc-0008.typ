#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

For a #tree-link("jc-000X")[monomorphism] $u : U arrow.r.hook A$ and a generalized element $x : Gamma -> A$ of $A$, we write $x in u$ if $x$ factors through $u$, i.e., there exists a morphism $phi : Gamma -> U$ such that $x = u phi$.
