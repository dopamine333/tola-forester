#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Yoneda lemma",
  taxon: "Theorem",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a locally small category, $F : cal(C)^"op" -> Set$ a contravariant set-valued functor, and $X$ an object of $cal(C)$. Then we have a bijection

$ hom_(Psh(cal(C)))(hom_cal(C)(-, X), F) tilde.equiv F(X) $

which sends a natural transformation $eta in hom_(Psh(cal(C)))(hom_cal(C)(-, X), F)$, i.e. $eta : hom_cal(C)(-, X) -> F$, to the element $eta_X (id_X) in F(X)$ (the essential core!). Here $Psh(cal(C)) := Set^(cal(C)^"op")$ denotes the presheaf category, whose objects are functors and whose morphisms are natural transformations. There is also a version for covariant set-valued functors $G : cal(C) -> Set$.
