#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

for monomorphism $u : U arrow.r.hook A, v : V arrow.r.hook A$, we write $u <= v$ if for all generalized element x of A, $x in u$ implies $x in v$. we write u \~ v if u ≤ v and v ≤ u.
