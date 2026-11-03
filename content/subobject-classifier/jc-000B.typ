#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

The subobjects of $A$ are the equivalence classes of #tree-link("jc-000X")[monomorphisms] into $A$ under $tilde.op$; in notation, $Sub(A) := {u bar.v u : U arrow.r.hook A " monic"} \/ tilde.op$. If the collection $Sub(A)$ is a set for every object $A$, the category is called well-powered.
