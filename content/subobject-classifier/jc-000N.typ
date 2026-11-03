#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Yoneda embedding",
  taxon: "Corollary",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a locally small category and $X, Y$ two objects of $cal(C)$. If we have an isomorphism

$ hom_cal(C)(Gamma, X) tilde.equiv hom_cal(C)(Gamma, Y) $

natural in $Gamma$ (i.e. a natural isomorphism $hom_cal(C)(-, X) tilde.equiv hom_cal(C)(-, Y)$), then $X tilde.equiv Y$. In the notation of generalized elements, it informally says that if $X$ and $Y$ have the same generalized elements, then $X$ and $Y$ are the same.
