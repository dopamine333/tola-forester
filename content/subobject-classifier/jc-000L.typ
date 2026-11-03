#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Yoneda Lemma",
  taxon: "Theorem",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a locally small category. Let $F : cal(C)^"op" -> Set$ be a contravariant set functor, X be an object in $cal(C)$. Then we have a bijection

$ hom_(Psh(cal(C)))(hom_cal(C)(-, X), F) tilde.equiv F(X) $

which send a natural transformation $eta in hom_(Psh(cal(C)))(hom_cal(C)(-, X), F)$ i.e. $eta : hom_cal(C)(-, X) -> F$ to the element $eta_X (id_X) in F(X)$ (the essential core!). where $Psh(cal(C)) := Set^(cal(C)^"op")$ denote the presheaf category which object are functor, morphism are natural transformation. we also have a version for covariant $G : cal(C) -> Set$ set functor.
