#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

Recall that we have the intersection $u inter v in Sub(A)$ of any subobjects $u, v in Sub(A)$, satisfying $x in u inter v <=> x in u and x in v$. Show that

$ Sub times Sub & -> Sub \
  Sub(A) times Sub(A) & -> Sub(A) \
  (u, v) & |-> u inter v $

is a natural transformation. Using $Sub tilde.equiv hom_cal(C)(-, Omega)$ and the Yoneda lemma, show that it induces a morphism $"and" : Omega times Omega -> Omega$ satisfying

$ "and" chevron.l p, q chevron.r = "true"_Gamma <=> (p = "true"_Gamma and q = "true"_Gamma) $

for all morphisms $p, q : Gamma -> Omega$. We call a morphism $p : Gamma -> Omega$ an internal predicate on $Gamma$, and we can understand $"and" : Omega times Omega -> Omega$ as the internal connective "and".
