#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

Recall that the diagonal embedding $Delta_A : A arrow.r.hook A times A$, $Delta_A := chevron.l id_A, id_A chevron.r$, satisfies $x = y$ if and only if $chevron.l x, y chevron.r in Delta_A$ for all generalized elements $x, y : Gamma -> A$. Define $eq_A : A times A -> Omega$ by $eq_A := chi_(Delta_A)$. Show that

$ x = y <=> eq_A chevron.l x, y chevron.r = "true"_Gamma $

We can understand $eq_A chevron.l x, y chevron.r : Gamma -> Omega$ as the internal proposition saying whether $x$ and $y$ are equal. Show that

$ pt & -> Sub(- times -) \
  {*} & -> Sub(A times A) \
  * & |-> Delta_A $

is NOT a natural transformation (why!?).
