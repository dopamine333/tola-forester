#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Example",
  date: "2026-11-03",
  author: "Justin",
))

Fix an object A, the diagonal embedding $Delta_A : A arrow.r.hook A times A, Delta_A := chevron.l id_A, id_A chevron.r$ is monic. it is a important step of internalize the equality of morphism, in the sense that, for all generalize element x, y of A with the same context, we have $x = y$ if and only if $chevron.l x, y chevron.r in Delta_A$.
