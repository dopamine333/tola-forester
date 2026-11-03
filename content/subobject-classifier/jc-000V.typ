#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

Recall that we have the diagonal embedding subobject $Delta_A : A arrow.r.hook A times A, Delta_A := chevron.l id_A, id_A chevron.r$ satisfies $x = y$ if and only if $chevron.l x, y chevron.r in Delta_A$ for all generalize element $x, y : Gamma -> A$. defined $eq_A : A times A -> Omega, eq_A := chi_(Delta_A)$. show that

$ x = y <=> eq_A chevron.l x, y chevron.r = "true"_Gamma $

we can understand $eq_A chevron.l x, y chevron.r : Gamma -> Omega$ as the internal proposition means $x, y$ are equal or not. Show that

$ pt & -> Sub(- times -) \
  {*} & -> Sub(A times A) \
  * & |-> Delta_A $

is NOT an natural transformation (why!?).
