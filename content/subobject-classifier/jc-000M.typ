#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Representable functor",
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a locally small category. A functor $F : cal(C)^"op" -> Set$ is called representable if there exist an object $X$ in $cal(C)$ and a natural isomorphism

$ theta : hom_cal(C)(-, X) tilde.equiv F $

In this case, $X$ is called the representing object of $F$. By the Yoneda lemma, $theta$ is uniquely determined by an element $e in F(X)$, called the universal element of $F$. There is also a version for covariant set-valued functors $G : cal(C) -> Set$.
