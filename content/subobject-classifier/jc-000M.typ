#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Representable functor",
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a locally small category. A functor $F : cal(C)^"op" -> Set$ is called representable if there exist some object $X$ in $cal(C)$ and a natural isomorphism

$ theta : hom_cal(C)(-, X) tilde.equiv F $

in this case, $X$ called the representing object of $F$. By Yoneda lemma, we have an element $e in F(X)$ unique determine $theta$, is called the universal element of $F$. we also have a version for covariant $G : cal(C) -> Set$ set functor.
